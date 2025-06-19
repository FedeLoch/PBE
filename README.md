# PBE - Pharo Benchmark Evaluation

<img width="1101" alt="Screenshot 2025-06-19 at 14 33 07" src="https://github.com/user-attachments/assets/9b375845-5989-434c-9fb0-f287facedea6" />


# Methodology Architecture

<img width="1012" alt="Screenshot 2025-06-19 at 14 33 43" src="https://github.com/user-attachments/assets/de0a0ada-c7d2-4c06-983c-9c705b996cbb" />


```Smalltalk
Metacello new
  baseline: 'BenchEvaluation';
  repository: 'github://FedeLoch/BenchEvaluation:main';
  onConflictUseIncoming;
  load.
```


### Temp solution

```Smalltalk
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

(Smalltalk at: #PBTREEPerformanceMutantExperiment) performExperimentAndSave.
```
