Class {
	#name : 'PBTPerformanceOperations',
	#superclass : 'Object',
	#category : 'BenchEvaluation-PerformanceMutants',
	#package : 'BenchEvaluation',
	#tag : 'PerformanceMutants'
}

{ #category : 'accessing' }
PBTPerformanceOperations class >> operators [
	
	^ #( 500 100 10 1 ) collect: [ :e | MTAddSleepOperator time: e ]
]
