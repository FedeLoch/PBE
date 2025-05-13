Class {
	#name : 'PBTExperimentConfig',
	#superclass : 'BenchConfig',
	#instVars : [
		'schema',
		'target',
		'time',
		'cases',
		'tests'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
PBTExperimentConfig >> cases: amount [ 
	
	cases := amount
]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> generateTests [

	super generateTests.
	tests := { result mutalkTest }.
]

{ #category : 'accessing' }
PBTExperimentConfig >> run [

	^ PBTBenchResult from: (time ifNil: [
		PBTRunner testWithLowCost: target from: schema times: cases
	] ifNotNil: [
		PBTRunner testWithLowCost: target from: schema for: time
	])
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema [

	^ schema
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema: anSchema [

	schema := anSchema 

]

{ #category : 'accessing' }
PBTExperimentConfig >> target: aTarget [

	target := aTarget 
]

{ #category : 'accessing' }
PBTExperimentConfig >> tests [
	
	^ tests
]

{ #category : 'accessing' }
PBTExperimentConfig >> time: aTime [

	time := aTime 
]
