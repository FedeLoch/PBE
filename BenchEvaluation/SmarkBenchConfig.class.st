Class {
	#name : 'SmarkBenchConfig',
	#superclass : 'BenchConfig',
	#instVars : [
		'benchmark',
		'times'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SmarkBenchConfig class >> for: benchmarkClass times: times [

	^ self new benchmark: benchmarkClass; times: times
]

{ #category : 'accessing' }
SmarkBenchConfig >> benchmark: benchmarkClass [

	benchmark := benchmarkClass 
]

{ #category : 'running' }
SmarkBenchConfig >> run [

	^ SmarkBenchResult from: (benchmark run: times)
]

{ #category : 'as yet unclassified' }
SmarkBenchConfig >> runWithCriteria: aBlock [

	^ self run
]

{ #category : 'accessing' }
SmarkBenchConfig >> times: count [

	times := count
]
