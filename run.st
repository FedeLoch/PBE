Metacello new
		baseline: 'Gnocco';
		repository: 'github://FedeLoch/Gnocco:release';
		onConflictUseIncoming;
		load;
		lock.

Metacello new
		baseline: 'BenchEvaluation';
		repository: 'github://FedeLoch/BenchEvaluation:main';
		onConflictUseIncoming;
		load.

PBTREEPerformanceMutantExperiment performExperimentAndSave.