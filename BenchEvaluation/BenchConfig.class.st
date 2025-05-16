Class {
	#name : 'BenchConfig',
	#superclass : 'Object',
	#instVars : [
		'title',
		'baseline'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
BenchConfig >> baseline [

	^ baseline 
]

{ #category : 'as yet unclassified' }
BenchConfig >> generateTests [

	baseline := self run.
]

{ #category : 'running' }
BenchConfig >> run [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
BenchConfig >> runAndSave [

	^ self generateTests
]

{ #category : 'as yet unclassified' }
BenchConfig >> runAndSaveBaseline [

	^ self generateTests
]

{ #category : 'as yet unclassified' }
BenchConfig >> runWithCriteria: aBlock [

	self subclassResponsibility 
]

{ #category : 'accessing' }
BenchConfig >> title [

	^ title
]

{ #category : 'accessing' }
BenchConfig >> title: aTitle [ 
	
	title := aTitle
]
