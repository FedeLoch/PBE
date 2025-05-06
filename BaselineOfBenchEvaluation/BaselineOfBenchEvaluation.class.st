Class {
	#name : 'BaselineOfBenchEvaluation',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBenchEvaluation',
	#package : 'BaselineOfBenchEvaluation'
}

{ #category : 'baselines' }
BaselineOfBenchEvaluation >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'PBT' with: [ spec repository: 'github://FedeLoch/PBT:main' ].
		spec baseline: 'Roassal' with: [ spec repository: 'github://pharo-graphics/Roassal/src' ].
		spec baseline: 'MuTalk' with: [ spec repository: 'github://pharo-contributions/mutalk:v2.6.0/src' ].
		spec baseline: 'OSSubprocess' with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ].
		spec package: 'BenchEvaluation' with: [ spec requires: #( 'PBT' 'MuTalk' 'Roassal' 'OSSubprocess' ) ]
	]
]
