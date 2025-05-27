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
	
	mutants at: mutant operator title update: [ :val | val + 1 ] initial: 0.
	
	(comparisons at: config title) at: mutant operator title ifAbsentPut: Dictionary new.
	
	((comparisons at: config title)
		at: mutant operator title)
		at: test name
		update: [ :val | val + ((self detected: test from: config) ifTrue: [ 1 ] ifFalse: [ 0 ]) ]
		initial: 0
]

{ #category : 'adding' }
BenchAnalysisResult >> detected: test from: config [

	^ self testSatisfy: test with: (self thresholdOf: config for: test)
]

{ #category : 'accessing' }
BenchAnalysisResult >> end [

	elapsedTime := Duration milliSeconds: (Smalltalk highResClock) - initialTime. 
]

{ #category : 'adding' }
BenchAnalysisResult >> initialize [ 

	super initialize.
	comparisons := Dictionary new.
	mutants := Dictionary new.
	
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBaselines [

	^ benchmarkConfigs do: [ :config |
		config plotBaselines inspect
	]
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBenchmarksEffectiveness [

	| heatMap values |
	
	heatMap := RSHeatmap new.
	heatMap colorPalette: (NSScale linear range: { Color white . Color red }).
	heatMap shape extent: 60@40.
	
	values := comparisons keys inject: OrderedCollection new into: [ :matrix :strategy | | localValues |
		localValues := (self sortedMutantsAt: strategy) collect: [ :mutant |
			Fraction numerator: (comparisons at: strategy at: mutant) denominator: (mutants at: mutant)
		].
		
		matrix add: localValues.
		matrix
	].
	
	heatMap objectsX: (self sortedMutantsAt: comparisons keys first).
	heatMap objectsY: comparisons keys.
   heatMap dataMatrix: values.
	
	^ heatMap open
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
