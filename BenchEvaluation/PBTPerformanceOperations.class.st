Class {
	#name : 'PBTPerformanceOperations',
	#superclass : 'Object',
	#category : 'BenchEvaluation-PerformanceMutants',
	#package : 'BenchEvaluation',
	#tag : 'PerformanceMutants'
}

{ #category : 'accessing' }
PBTPerformanceOperations class >> operators [

	^ {
		  (MTAddSleepOperator time: 500).
		  (MTAddSleepOperator time: 100).
"		  (MTAddSleepOperator time: 50).
		  (MTAddSleepOperator time: 20)."
		  (MTAddSleepOperator time: 10).
		  "(MTAddSleepOperator time: 1)"
	}
]
