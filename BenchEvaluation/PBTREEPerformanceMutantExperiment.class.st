Class {
	#name : 'PBTREEPerformanceMutantExperiment',
	#superclass : 'PBTRandomREExperiment',
	#instVars : [
		'baseline',
		'threshold'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> analyze [

	^ self new time: 1 seconds; analyze
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> performExperimentsByCounOfCases: cases [

	^ cases collect: [ :amount | self new countOfCases: amount; analyze ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> performExperimentsWithTimes: times [

	^ times collect: [ :time | self new time: time; analyze ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> performExperimentsWithTimes: times threshold: aThreshold [

	^ times collect: [ :time | self new time: time; threshold: aThreshold; analyze ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> baseLinePbtConfiguration [

	^ self
		  executionConfig:
		  (self schemaWith: self simpleRegexConfig)
		  called: 'Baseline'
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> criteriaLabel [

	^ time ifNil: [ countOfCases asString, ' times' ] ifNotNil: [ self time humanReadablePrintString ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> methodsToMutate [

	^ self target sendReachableMethods
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> mutants [

	^ (MTManualMutatedMethodGenerationStrategy new targetMethods:
		   self target sendReachableMethods) mutationsFor:
		  PBTPerformanceOperations
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> simpleRegexConfig [

	^ PBTObjectConstraint new generator:
		  (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> threshold [

	^ threshold
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> threshold: aThreshold [

	threshold := aThreshold
]
