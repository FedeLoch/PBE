Class {
	#name : 'SMarkDeltaBlueAnalysis',
	#superclass : 'BenchAnalysis',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'initialization' }
SMarkDeltaBlueAnalysis >> benchmarkConfigs [

	^ { SmarkBenchConfig for: SMarkDeltaBlue times: 10 }
]

{ #category : 'private' }
SMarkDeltaBlueAnalysis >> criteriaLabel [

	^ 'SMark DeltaBlue benchmark analysis'
]

{ #category : 'initialization' }
SMarkDeltaBlueAnalysis >> methodsToMutate [

	^ self allMethodsOfPackage: 'SOM-Benchmarks' inTag: 'DeltaBlue'.
]
