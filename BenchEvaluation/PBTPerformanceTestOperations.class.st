Class {
	#name : 'PBTPerformanceTestOperations',
	#superclass : 'Object',
	#classInstVars : [
		'test'
	],
	#category : 'BenchEvaluation-PerformanceMutants',
	#package : 'BenchEvaluation',
	#tag : 'PerformanceMutants'
}

{ #category : 'accessing' }
PBTPerformanceTestOperations class >> operators [

	^ #( 500 100 10 1 ) collect: [ :e |
		(MTAddSleepOperator time: e / test autoTunedIterations) description: e asString, ' ms'
	]
]

{ #category : 'accessing' }
PBTPerformanceTestOperations class >> test: aTest [

	test := aTest 
]
