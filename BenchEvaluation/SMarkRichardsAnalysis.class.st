Class {
	#name : 'SMarkRichardsAnalysis',
	#superclass : 'BenchAnalysis',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'initialization' }
SMarkRichardsAnalysis >> benchmarkConfigs [

	^ { SmarkBenchConfig for: SMarkRichards times: 5 }
]

{ #category : 'private' }
SMarkRichardsAnalysis >> criteriaLabel [

	^ 'SMark Richard benchmark analysis'
]

{ #category : 'initialization' }
SMarkRichardsAnalysis >> methodsToMutate [

	^ self allMethodsOfPackage: 'SOM-Benchmarks' inTag: 'Richards'.
]
