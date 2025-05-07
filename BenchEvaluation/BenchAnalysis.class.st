Class {
	#name : 'BenchAnalysis',
	#superclass : 'Object',
	#instVars : [
		'benchmarkConfigs',
		'mutants'
	],
	#category : 'BenchEvaluation-Analysis',
	#package : 'BenchEvaluation',
	#tag : 'Analysis'
}

{ #category : 'private' }
BenchAnalysis >> analyze [

	"Given a sensitivity level T,
		1 - We generate a base sample of N inputs.
		2 - We generate a box plot for each result.
		3 - Per each Mutant m_i, we install it
			3.1 - Per each config c_j, we generate N inputs ( MM )
			3.2 - We compare each MM_k with respect to the boxplot and we select the outliers number for m_i
			3.3 - We save the amount of outliers who identified the effect of m_i"
			
	^ mutants inject: (BenchAnalysisResult new title: 'Result running ', self criteriaLabel, ' each configuration ') into: [ :r :mutant |
		mutant install.
		benchmarkConfigs do: [ :config | r add: config run called: config title forMutant: mutant withBaseline: config result ].
		mutant uninstall.
		r.
	]
]

{ #category : 'initialization' }
BenchAnalysis >> benchmarkConfigs [

	self subclassResponsibility
]

{ #category : 'accessing' }
BenchAnalysis >> classesToMutate [

	self subclassResponsibility
]

{ #category : 'private' }
BenchAnalysis >> criteriaLabel [

	^ self subclassResponsibility 
]

{ #category : 'initialization' }
BenchAnalysis >> initialize [

	super initialize.
	mutants := self mutants.
	benchmarkConfigs := self benchmarkConfigs.
	benchmarkConfigs do: #generateTests
]

{ #category : 'initialization' }
BenchAnalysis >> methodsToMutate [

	^ self subclassResponsibility 
]

{ #category : 'initialization' }
BenchAnalysis >> mutants [

	^ (MTManualMutatedMethodGenerationStrategy new targetMethods: self methodsToMutate) mutationsFor: PBTPerformanceOperations
]
