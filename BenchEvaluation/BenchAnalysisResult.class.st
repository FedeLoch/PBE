Class {
	#name : 'BenchAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'comparisons',
		'mutants',
		'title',
		'initialTime',
		'elapsedTime',
		'benchmarkConfigs'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
BenchAnalysisResult >> benchmarkConfigs [

	^ benchmarkConfigs
]

{ #category : 'accessing' }
BenchAnalysisResult >> benchmarkConfigs: someBenchmarkConfigs [

	benchmarkConfigs := someBenchmarkConfigs
]

{ #category : 'adding' }
BenchAnalysisResult >> detect: test from: config forMutant: mutant [

	comparisons at: config title ifAbsentPut: Dictionary new.

	(comparisons at: config title) at: mutant operator title ifAbsentPut: Dictionary new.
	
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

{ #category : 'adding' }
BenchAnalysisResult >> initialize [ 

	super initialize.
	comparisons := Dictionary new.
	mutants := Dictionary new.
	
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
