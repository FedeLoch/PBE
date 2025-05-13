Class {
	#name : 'MTAddSleepOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#instVars : [
		'milliseconds'
	],
	#category : 'BenchEvaluation-PerformanceMutants',
	#package : 'BenchEvaluation',
	#tag : 'PerformanceMutants'
}

{ #category : 'accessing' }
MTAddSleepOperator class >> time: milliseconds [

	^ self new milliseconds: milliseconds 
]

{ #category : 'printing' }
MTAddSleepOperator >> appliesToNode: aNode [

	^ aNode isSequence
]

{ #category : 'printing' }
MTAddSleepOperator >> description [

	^ self milliseconds asString, ' ms'
]

{ #category : 'as yet unclassified' }
MTAddSleepOperator >> milliseconds [

	^ milliseconds
]

{ #category : 'as yet unclassified' }
MTAddSleepOperator >> milliseconds: someMilliseconds [

	milliseconds := someMilliseconds
]

{ #category : 'printing' }
MTAddSleepOperator >> newNodeFrom: aSequenceNode [

	| copy |
	copy := aSequenceNode copy.
	copy statements: { self node parent: copy; yourself }, copy statements.
	
	^ copy
]

{ #category : 'accessing' }
MTAddSleepOperator >> node [
	^ RBParser parseExpression: '(Delay forMilliseconds:', self milliseconds asString, ') wait'.
]

{ #category : 'accessing' }
MTAddSleepOperator >> title [
	
	^ self description.
]
