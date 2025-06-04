Class {
	#name : 'SingletonTestConfig',
	#superclass : 'BenchConfig',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'instance creation' }
SingletonTestConfig class >> from: test [

	^ self new tests: { test }
]
