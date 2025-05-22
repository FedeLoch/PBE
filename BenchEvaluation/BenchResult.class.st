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

{ #category : 'as yet unclassified' }
BenchResult >> boxPlot [

	self subclassResponsibility .
]

{ #category : 'accessing' }
BenchResult >> median [

	^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
BenchResult >> mutalkTest [

	^ self subclassResponsibility 
]

{ #category : 'printing' }
BenchResult >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	aStream print: self time asFloat.
	aStream nextPutAll: '+-'.
	aStream print: self stdev asFloat.
	aStream nextPut: $)
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
BenchResult >> tests [

	self subclassResponsibility 
]

{ #category : 'accessing' }
BenchResult >> time [

	^ self subclassResponsibility 
]
