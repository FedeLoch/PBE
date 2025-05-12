Class {
	#name : 'BenchAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'comparisons',
		'fixedThreshold',
		'mutants',
		'title'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'adding' }
BenchAnalysisResult >> add: benchResult called: resultName forMutant: mutant withBaseline: benchBaseline [

	comparisons at: resultName ifAbsentPut: Dictionary new.
	
	mutants at: mutant operator title update: [ :val | val + 1 ] initial: 0.
	
	(comparisons at: resultName)
		at: mutant operator title
		update: [ :val | val + ((self detected: benchResult fromBase: benchBaseline) ifTrue: [ 1 ] ifFalse: [ 0 ]) ]
		initial: 0
]

{ #category : 'adding' }
BenchAnalysisResult >> detected: benchResult fromBase: benchBaseline [

	^ benchResult time >= (self thresholdOf: benchResult)
]

{ #category : 'adding' }
BenchAnalysisResult >> initialize [ 

	super initialize.
	comparisons := Dictionary new.
	mutants := Dictionary new.
	
]

{ #category : 'private - inspector accessing' }
BenchAnalysisResult >> plotBenchmarksEffectiveness [

	| heatMap values |
	
	heatMap := RSHeatmap new.
	heatMap shape extent: 40@20.
	values := comparisons keys inject: OrderedCollection new into: [ :matrix :strategy | | localValues |

		localValues := (self sortedMutantsAt: strategy) collect: [ :mutant |
			(comparisons at: strategy at: mutant) / (mutants at: mutant)
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

	^ (comparisons at: aStrategy) keys sort: [ :m1 :m2 | (m1 splitOn: ' ') last asInteger < (m2 splitOn: ' ') last asInteger ]
]

{ #category : 'adding' }
BenchAnalysisResult >> thresholdOf: benchBaseLine [

	fixedThreshold ifNotNil: [ ^ fixedThreshold ].

	^ benchBaseLine median + benchBaseLine stdev
]

{ #category : 'adding' }
BenchAnalysisResult >> title: aTitle [

	title := aTitle 
]
