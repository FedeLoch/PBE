Class {
	#name : 'PBTBugDetectionExperiment',
	#superclass : 'BenchAnalysis',
	#instVars : [
		'pbtTests',
		'pbtConfigurations'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment class >> analyze [

	^ self new analyze
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> countOfCases [

	^ countOfCases
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> countOfCases: anAmount [

	countOfCases := anAmount 
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> executionConfig: schema called: title [

	schema guidedByExecutionTime.
	^ PBTExperimentConfig new schema: schema; title: title; cases: self countOfCases; time: self time; target: self target
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> target [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> time [

	self subclassResponsibility 
]
