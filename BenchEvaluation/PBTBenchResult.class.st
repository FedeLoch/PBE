Class {
	#name : 'PBTBenchResult',
	#superclass : 'BenchResult',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

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
PBTBenchResult >> time [ 

	^ result times average
]
