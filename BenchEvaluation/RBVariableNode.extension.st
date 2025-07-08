Extension { #name : 'RBVariableNode' }

{ #category : '*BenchEvaluation' }
RBVariableNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties variable )
]
