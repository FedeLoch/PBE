Class {
	#name : 'BenchConfig',
	#superclass : 'Object',
	#instVars : [
		'title',
		'baseline'
	],
	#category : 'BenchEvaluation-BenchmarkConfig',
	#package : 'BenchEvaluation',
	#tag : 'BenchmarkConfig'
}

{ #category : 'accessing' }
BenchConfig >> baseline [

	^ baseline 
]

{ #category : 'as yet unclassified' }
BenchConfig >> generateTests [
	
	baseline := self run.
]

{ #category : 'as yet unclassified' }
BenchConfig >> medianFor: test [

	self subclassResponsibility 
]

{ #category : 'private - inspector accessing' }
BenchConfig >> plotBaselines [

	self subclassResponsibility 
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

{ #category : 'as yet unclassified' }
BenchConfig >> stdevFor: test [

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
