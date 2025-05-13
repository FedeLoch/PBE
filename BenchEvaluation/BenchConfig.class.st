Class {
	#name : 'BenchConfig',
	#superclass : 'Object',
	#instVars : [
		'title',
		'result'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
BenchConfig >> generateTests [

	result := self run.
]

{ #category : 'accessing' }
BenchConfig >> result [

	^ result
]

{ #category : 'running' }
BenchConfig >> run [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
BenchConfig >> runAndSave [

	^ self generateTests
]

{ #category : 'accessing' }
BenchConfig >> title [

	^ title
]

{ #category : 'accessing' }
BenchConfig >> title: aTitle [ 
	
	title := aTitle
]
