Class {
	#name : 'PBTRegex',
	#superclass : 'Object',
	#instVars : [
		'regexString',
		'regex'
	],
	#category : 'BenchEvaluation-PerformanceMutants',
	#package : 'BenchEvaluation',
	#tag : 'PerformanceMutants'
}

{ #category : 'instance creation' }
PBTRegex class >> fromString: aString [

	^ self new
		  regexString: aString;
		  yourself
]

{ #category : 'ston-core' }
PBTRegex class >> stonAllInstVarNames [ 

	^ super stonAllInstVarNames copyWithout: #regex
]

{ #category : 'compiling' }
PBTRegex >> compileRegex [

	^ regexString asRegex
]

{ #category : 'testing' }
PBTRegex >> matches: aString [ 
	
	^ self regex matches: aString
]

{ #category : 'accessing' }
PBTRegex >> regex [

	^ regex ifNil: [ regex := regexString asRegex ]
]

{ #category : 'accessing' }
PBTRegex >> regexString [

	^ regexString
]

{ #category : 'accessing' }
PBTRegex >> regexString: anObject [

	regexString := anObject
]
