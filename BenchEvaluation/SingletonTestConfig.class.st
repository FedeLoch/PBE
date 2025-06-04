Class {
	#name : 'SingletonTestConfig',
	#superclass : 'BenchConfig',
	#instVars : [
		'test',
		'countOfTimesPerTest'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'instance creation' }
SingletonTestConfig class >> from: test [

	^ self new test: test
]

{ #category : 'as yet unclassified' }
SingletonTestConfig >> averageFor: aTest [

	^ baseline third
]

{ #category : 'initialization' }
SingletonTestConfig >> initialize [ 

	super initialize.
	countOfTimesPerTest := 30
]

{ #category : 'as yet unclassified' }
SingletonTestConfig >> medianFor: aTest [

	^ baseline first
]

{ #category : 'as yet unclassified' }
SingletonTestConfig >> stdevFor: aTest [

	^ baseline last
]

{ #category : 'accessing' }
SingletonTestConfig >> test [

	^ test
]

{ #category : 'accessing' }
SingletonTestConfig >> test: aTest [

	| times|
	test := aTest.
	times := test runTimes: countOfTimesPerTest withInternalIterations: (test autoTuneIterationsFor: 300 milliSeconds).
	baseline := { times median . times stdev. times average }.
]
