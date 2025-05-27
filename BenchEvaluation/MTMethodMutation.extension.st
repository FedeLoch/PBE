Extension { #name : 'MTMethodMutation' }

{ #category : '*BenchEvaluation' }
MTMethodMutation >> stonOn: stonWriter [

	stonWriter writeObject: self streamMap: [ :dictionary |
		(self class stonAllInstVarNames copyWithoutAll:
			 { #originalProtocol. #originalMethod. #data }) do: [ :e |
			dictionary at: e put: (self instVarNamed: e) ].
		dictionary at: #originalMethod put: originalMethod name.
		dictionary at: #data put: data path ]
]

{ #category : '*BenchEvaluation' }
MTMethodMutation >> stonProcessSubObjects: aBlock [

	super stonProcessSubObjects: aBlock.

	originalMethod := Object readFrom: originalMethod.
	data := self originalMethod ast childAtPath: data
]
