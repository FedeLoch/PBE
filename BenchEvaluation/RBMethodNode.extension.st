Extension { #name : 'RBMethodNode' }

{ #category : '*BenchEvaluation' }
RBMethodNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties compilationContext )
]
