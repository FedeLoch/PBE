Class {
	#name : 'PBTExperimentConfig',
	#superclass : 'BenchConfig',
	#instVars : [
		'schema',
		'target',
		'time',
		'cases',
		'tests',
		'baselines',
		'countOfTimesPerTest'
	],
	#category : 'BenchEvaluation-BenchmarkConfig',
	#package : 'BenchEvaluation',
	#tag : 'BenchmarkConfig'
}

{ #category : 'ston-core' }
PBTExperimentConfig class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( target )
]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> averageFor: test [

	^ (baselines at: test name) third
]

{ #category : 'accessing' }
PBTExperimentConfig >> cases: amount [ 

	cases := amount
]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> generateTests [
	
	tests := self run tests.
	baselines := tests inject: Dictionary new into: [ :blines :test | | times |
		times := test runTimes: countOfTimesPerTest withInternalIterations: (test autoTuneIterationsFor: 300 milliSeconds).
		blines at: test name put: { times median . times stdev. times average }.
		blines.
	].
]

{ #category : 'initialization' }
PBTExperimentConfig >> initialize [ 

	super initialize.
	countOfTimesPerTest := 30
]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> medianFor: test [

	^ (baselines at: test name) first
]

{ #category : 'private - inspector accessing' }
PBTExperimentConfig >> plotBaselines [

	| plot medians stdevs allKeys |
	allKeys := baselines keys.
	medians := allKeys collect: [ :key | (baselines at: key) last ].
	stdevs := allKeys collect: [ :key | (baselines at: key) second ].
	plot := (RSBarPlot barHeights: medians) errors: stdevs.
	plot verticalTick labelConversion: [ :val | val asFloat printShowingDecimalPlaces: 5 ].
	plot title: 'Baselines of tests - ', self title.
	plot yLog.
	^ plot
]

{ #category : 'accessing' }
PBTExperimentConfig >> run [

	^ PBTBenchResult from: (time ifNil: [
		PBTRunner testWithPackageCoverage: target from: schema times: cases
	] ifNotNil: [
		PBTRunner testWithPackageCoverage: target from: schema for: time
	])
]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> runWithCriteria: aBlock [

	^ PBTBenchResult from: (PBTRunner testWithLowCost: target from: schema withCriteria: aBlock)
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema [

	^ schema
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema: anSchema [

	schema := anSchema 

]

{ #category : 'as yet unclassified' }
PBTExperimentConfig >> stdevFor: test [

	^ (baselines at: test name) last
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
