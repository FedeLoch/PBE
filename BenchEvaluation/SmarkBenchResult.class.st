Class {
	#name : 'SmarkBenchResult',
	#superclass : 'BenchResult',
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
SmarkBenchResult >> median [ 
	
	^ self times median
]

{ #category : 'accessing' }
SmarkBenchResult >> stdev [ 
	
	^ self times stdev
]

{ #category : 'accessing' }
SmarkBenchResult >> time [ 
	
	^ self times average
]

{ #category : 'accessing' }
SmarkBenchResult >> times [

	^ result results asOrderedCollection first collect: #total
]
