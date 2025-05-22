Class {
	#name : 'PBTBenchResult',
	#superclass : 'BenchResult',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
PBTBenchResult >> boxPlot [
	
	| plot tests |
	
	tests := result tests.

	plot := RSBoxPlot new y: (tests ifEmpty: [ { 1 } ] ifNotEmpty: [ (tests collect: [ :t | t result time asMilliSeconds ]) ]); yLog; yourself.
	plot horizontalTick numberOfTicks: tests size.
	plot ylabel: 'Time execution in milliseconds'; xlabel: '( ', tests size asString, ' cases )'.
	
	^ plot asShape
]

{ #category : 'accessing' }
PBTBenchResult >> median [ 
	
	^ result times median
]

{ #category : 'as yet unclassified' }
PBTBenchResult >> mutalkTest [

	^ result mutalkTest
]

{ #category : 'accessing' }
PBTBenchResult >> stdev [ 
	
	^ result times stdev
]

{ #category : 'accessing' }
PBTBenchResult >> tests [ 

	^ result tests
]

{ #category : 'accessing' }
PBTBenchResult >> time [ 

	^ result times average
]
