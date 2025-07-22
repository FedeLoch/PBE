Class {
	#name : 'TestsAnalysisResult',
	#superclass : 'BenchAnalysisResult',
	#instVars : [
		'benchmarkConfig'
	],
	#category : 'BenchEvaluation-Result',
	#package : 'BenchEvaluation',
	#tag : 'Result'
}

{ #category : 'accessing' }
TestsAnalysisResult >> benchmarkConfig [

	^ benchmarkConfig 
]

{ #category : 'accessing' }
TestsAnalysisResult >> benchmarkConfig: config [

	benchmarkConfig := config. 
]

{ #category : 'as yet unclassified' }
TestsAnalysisResult >> codeCoverageCorrelation: strategy mutant: mutant [

	^ self codeCoverageCorrelationFromTests: benchmarkConfig tests strategy: strategy mutant: mutant
]

{ #category : 'accessing' }
TestsAnalysisResult >> computeTestsPercentages [

	self benchmarkConfig tests do: [ :t |
		t result coverageResult fixedPercentage ]
]
