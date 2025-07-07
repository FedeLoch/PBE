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

	^ #( 500 100 10 ) collect: [ :e | MTAddSleepOperator time: (e / test autoTunedIterations) ]
]

{ #category : 'accessing' }
PBTPerformanceTestOperations class >> test: aTest [

	test := aTest 
]
