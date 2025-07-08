Extension { #name : 'RBProgramNode' }

{ #category : '*BenchEvaluation' }
RBProgramNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties )
]
