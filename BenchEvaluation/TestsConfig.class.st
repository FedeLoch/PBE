Class {
	#name : 'TestsConfig',
	#superclass : 'BenchConfig',
	#instVars : [
		'tests',
		'baselines',
		'countOfTimesPerTest'
	],
	#category : 'BenchEvaluation-BenchmarkConfig',
	#package : 'BenchEvaluation',
	#tag : 'BenchmarkConfig'
}

{ #category : 'as yet unclassified' }
TestsConfig >> averageFor: test [

	^ (baselines at: test name) third
]

{ #category : 'initialization' }
TestsConfig >> initialize [ 

	super initialize.
	countOfTimesPerTest := 30
]

{ #category : 'as yet unclassified' }
TestsConfig >> medianFor: test [

	^ (baselines at: test name) first
]

{ #category : 'private - inspector accessing' }
TestsConfig >> plotBaselines [

	| plot medians stdevs allKeys |
	allKeys := baselines keys.
	medians := allKeys collect: [ :key | (baselines at: key) last ].
	stdevs := allKeys collect: [ :key | (baselines at: key) second ].
	plot := (RSBarPlot barHeights: medians) errors: stdevs.
	plot verticalTick labelConversion: [ :val | val asFloat printShowingDecimalPlaces: 3 ].
	plot title: 'Baselines'.
	plot yLog.
	^ plot
]

{ #category : 'as yet unclassified' }
TestsConfig >> stdevFor: test [

	^ (baselines at: test name) last
]

{ #category : 'accessing' }
TestsConfig >> tests [
	^ tests
]

{ #category : 'accessing' }
TestsConfig >> tests: someTests [

	someTests do: #resetAutotune.
	tests := someTests.
	baselines := tests inject: Dictionary new into: [ :blines :test | | times |
		times := test runTimes: countOfTimesPerTest withInternalIterations: (test autoTuneIterationsFor: 300 milliSeconds).
		blines at: test name put: { times median . times stdev. times average }.
		blines.
	].
]
