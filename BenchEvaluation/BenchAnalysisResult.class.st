Class {
	#name : 'BenchAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'comparisons',
		'mutants',
		'title',
		'initialTime',
		'elapsedTime',
		'benchmarkConfigs',
		'experiment'
	],
	#category : 'BenchEvaluation-Result',
	#package : 'BenchEvaluation',
	#tag : 'Result'
}

{ #category : 'accessing' }
BenchAnalysisResult >> benchmarkConfigs [

	^ benchmarkConfigs
]

{ #category : 'accessing' }
BenchAnalysisResult >> benchmarkConfigs: someBenchmarkConfigs [

	benchmarkConfigs := someBenchmarkConfigs
]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> codeCoverageCorrelation [

	comparisons keysDo: [ :key | self codeCoverageCorrelation: key ]
]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> codeCoverageCorrelation: strategy [

	(comparisons at: strategy) keys sorted do: [ :mutantKey |
		self codeCoverageCorrelation: strategy mutant: mutantKey
	]
]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> codeCoverageCorrelation: strategy mutant: mutant [

	| tests |

	tests := (benchmarkConfigs at:
		          (benchmarkConfigs findFirst: [ :config |
			           config title = strategy ])) tests.
		
	^ self codeCoverageCorrelationFromTests: tests strategy: strategy mutant: mutant

]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> codeCoverageCorrelationFromTests: tests strategy: strategy mutant: mutant [ 

	| composite plot x y regression correlationCoef legend |
	composite := RSCompositeChart new.
	plot := RSScatterPlot new.

	x := (comparisons at: strategy at: mutant) keys collect: [ :test |
		     ((comparisons at: strategy at: mutant) at: test) size * 100
		     / (mutants at: mutant) ].

	y := tests collect: [ :test |
		     test result coverageResult
			     ifNil: [ 0 ]
			     ifNotNil: [ test result coverageResult fixedPercentage ] ].

	plot x: x y: y.
	composite 
		xlabel: 'Mutation score';
		ylabel: 'Code coverage'.
	regression := self linealRegressionLineFrom: x andY: y.
	composite add: (RSLinePlot new y: ((1 to: x max) collect: [ :_x |
				  regression slope * _x + regression intercept ])).

	composite add: plot.
	correlationCoef := (regression correlationCoefficient  * 100) round: 3.
	composite title: mutant.
	legend := RSLegend new.
	legend text: 'Correlation coefficient: ', correlationCoef asString, '%'.
	legend legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 1 ].
	legend location top; center; offset: 100.
	legend container: composite canvas.
	legend build.
	
	^ composite build inspect
]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> computeTestsPercentages [

	self benchmarkConfigs do: [ :config |
		config tests do: [ :t | t result coverageResult fixedPercentage ] ]
]

{ #category : 'adding' }
BenchAnalysisResult >> detect: test from: config forMutant: mutant [

	comparisons at: config title ifAbsentPut: OrderedDictionary new.

	(comparisons at: config title) at: mutant operator title ifAbsentPut: OrderedDictionary new.
	
	((comparisons at: config title)
		at: mutant operator title)
		at: test name
		update: [ :set | ((self detected: test from: config) ifTrue: [ set copyWith: mutant ] ifFalse: [ set ]) ]
		initial: Set new
]

{ #category : 'adding' }
BenchAnalysisResult >> detected: test from: config [

	^ self testSatisfy: test with: (self thresholdOf: config for: test)
]

{ #category : 'accessing' }
BenchAnalysisResult >> end [

	elapsedTime := Duration nanoSeconds: ((Smalltalk highResClock) - initialTime). 
]

{ #category : 'accessing' }
BenchAnalysisResult >> experiment [

	^ experiment 
]

{ #category : 'accessing' }
BenchAnalysisResult >> experiment: anExperiment [

	experiment := anExperiment 
]

{ #category : 'adding' }
BenchAnalysisResult >> initialize [ 

	super initialize.
	comparisons := OrderedDictionary new.
	mutants := OrderedDictionary new.
	
]

{ #category : 'as yet unclassified' }
BenchAnalysisResult >> linealRegressionLineFrom: xs andY: ys [

	| linReg n |
	n := xs size.
	n = 0 ifTrue: [ ^ RSLinePlot new color: Color red ].
	
	linReg := PMLinearRegression new.
	(1 to: n) do: [:i | linReg add: (xs at: i) @ (ys at: i) ].
	
	^ linReg

]

{ #category : 'adding' }
BenchAnalysisResult >> mutants: someMutants [

	| grouped |
	grouped := someMutants groupedBy: [ :m | m operator title ].
	mutants := grouped keys inject: Dictionary new into: [ :dic :key |
		dic at: key put: (grouped at: key) size.
		dic
	] 
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBaselines [

	^ benchmarkConfigs do: [ :config | config plotBaselines inspect ]
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBenchmarkConfig: strategy [

	| heatMap values tests mutantKeys |
	
	heatMap := RSHeatmap new.
	heatMap colorPalette: (NSScale linear range: { Color white . Color red }).
	heatMap shape extent: 60@40.
	
	mutantKeys := (comparisons at: strategy) keys sorted.
	tests := (comparisons at: strategy at: mutantKeys first) keys.
	values := tests inject: OrderedCollection new into: [ :matrix :test | | localValues |
		localValues := mutantKeys collect: [ :mutant |
			Fraction numerator: ((comparisons at: strategy at: mutant) at: test) size denominator: (mutants at: mutant)
		].
		matrix add: localValues.
		matrix
	].

	heatMap objectsX: mutantKeys.
	heatMap objectsY: (1 to: tests size).
   heatMap dataMatrix: values.
	
	^ heatMap open
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBenchmarksEffectiveness [

	comparisons keysDo: [ :key | self plotBenchmarkConfig: key ]
]

{ #category : 'running' }
BenchAnalysisResult >> runTest: testId [
	
	| testCaseIndex |
	
	testCaseIndex := benchmarkConfigs first tests findFirst: [ :test | test name = testId ].
	^ experiment executeExperimentFor: (benchmarkConfigs first tests at: testCaseIndex)
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> sortedMutantsAt: aStrategy [

	^ (comparisons at: aStrategy) keys sort: [ :m1 :m2 | (m1 splitOn: ' ') first asInteger > (m2 splitOn: ' ') first asInteger ]
]

{ #category : 'accessing' }
BenchAnalysisResult >> start [

	initialTime := Smalltalk highResClock.
]

{ #category : 'tests' }
BenchAnalysisResult >> testSatisfy: aTest for: aConfig [

	^ self testSatisfy: aTest with: (self thresholdOf: aConfig for: aTest) 
	
]

{ #category : 'tests' }
BenchAnalysisResult >> testSatisfy: test with: threshold [

	^ test runTimeAutotuned >= threshold
	
]

{ #category : 'adding' }
BenchAnalysisResult >> thresholdOf: config for: test [

	| stdevs |
	stdevs := 1.

	^ (config averageFor: test) + (stdevs * (config stdevFor: test))
]

{ #category : 'adding' }
BenchAnalysisResult >> title: aTitle [

	title := aTitle 
]
