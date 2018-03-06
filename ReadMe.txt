Task Design:
- trials design in monetary and medical blocks should be identical, the only difference is outcome level in money/description
- outcome has 4 levels (vals): $5 $8 $12 $25 for monetary; slight improvement, moderate improvement, major improvement and recovery for medical
- 3 probability: 0.25 0.5 0.75
- 4 ambiguity: 0.24 0.5 0.74 
- 4 repeats for each trial, except that the lowest reference level only has one repeat 
- 78 trials for each domain (monetary/medical), altogether 156 trials
- add two trials with the reference level in each block, to make 160 total trials, easy to split between blocks. 
- add a trial with the reference level at the start of eachblock, will be excluded from imaging anlaysis
- for each trial: 6s display + 3.5s reaction + 0.5s feedback + 5s ITI (jittered average) = 15s
- 8 blocks,  21 trials per block, 315+20s per block, about 6 min




How to run:
-Practice: MDM_PTB_practice_v2, include subject number in parenthesis, e.g. MDM_PTB_practice_v2(1111)
-Task: the task includes 4 separate scripts, each running 2 blocks (one monetary and one medical, randomized for each task script). MDM_PTB_s1_v1 stands for M(edical)D(ecision)M(aking)_P(sych)T(ool)B(ox)_s(ession)1_v(ersion)2. Include subject number in parenthesis, e.g. MDM_PTB_practice_v2(1111). Make sure to run the four task scripts in the order of s1, s2, s3 and s4.

Script version:
v1: only the medical task has symbol.4 sessions, monetary and medical randomized for each session.
v2: add the monetary symbol. Two medical blocks and two monetary blocks together.2-2-2-2




