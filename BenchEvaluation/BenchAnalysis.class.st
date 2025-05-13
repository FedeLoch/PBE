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

{ #category : 'running' }
BenchAnalysis class >> run [

	^ self new analyze
]

{ #category : 'as yet unclassified' }
BenchAnalysis >> allMethodsOfPackage: package inTag: atag [

	^ (RPackageOrganizer default packageNamed: package) definedClasses inject: OrderedCollection new into: [ :acc :className |
		(className packageTag name = atag) ifTrue: [
			acc addAll: className methods
		].
	acc
]
]

{ #category : 'private' }
BenchAnalysis >> analyze [

	self setUpBenchmarks.

	^ mutants inject: (BenchAnalysisResult new title: 'Result running ', self criteriaLabel, ' each configuration ') into: [ :result :mutant |
		mutant install.
		benchmarkConfigs do: [ :config | result add: config run called: config title forMutant: mutant withBaseline: config result ].
		mutant uninstall.
		result.
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
]

{ #category : 'initialization' }
BenchAnalysis >> methodsToMutate [

	^ self subclassResponsibility 
]

{ #category : 'initialization' }
BenchAnalysis >> mutants [

	^ (MTManualMutatedMethodGenerationStrategy new targetMethods: self methodsToMutate) mutationsFor: PBTPerformanceOperations
]

{ #category : 'initialization' }
BenchAnalysis >> setUpBenchmarks [

	benchmarkConfigs := self benchmarkConfigs.
	benchmarkConfigs do: [ :config | config generateTests ]
]
