Class {
	#name : 'BenchResult',
	#superclass : 'Object',
	#instVars : [
		'result'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'instance creation' }
BenchResult class >> from: benchmarkResult [

	^ self new result: benchmarkResult
]

{ #category : 'accessing' }
BenchResult >> median [

	^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
BenchResult >> mutalkTest [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
BenchResult >> result: benchMarkResult [

	result := benchMarkResult
]

{ #category : 'accessing' }
BenchResult >> stdev [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
BenchResult >> time [

	^ self subclassResponsibility 
]
