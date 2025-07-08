Extension { #name : 'SortedCollection' }

{ #category : '*BenchEvaluation' }
SortedCollection class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( sortBlock )
]
