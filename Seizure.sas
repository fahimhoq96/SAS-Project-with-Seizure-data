/** SAS project by Fahim Hoq **/

/** Seizure Data **/

Proc format;
	value fmttrt 	0 = "Placebo" 
					1 = "Progabide" 
run;

Data Seizure;
infile 'C:\DATS7510\SAS/seizure.txt';
input PID 1-2 Seizure1 9-11  Seizure2 17-18 Seizure3 25-26 Seizure4 33-34 Trt 41 BaseSeizure 49-51 Age 57-58;
format Trt fmttrt.;
label PID = "Patient Identifier" Seizure1 = "Seizure Count Week 1" Seizure2 = "Seizure Count Week 2" Seizure3 = "Seizure Count Week 3" Seizure4 = "Seizure Count Week 4" Trt = "Treatment" BaseSeizure = "Base Seizure Rate" Age = "Age of the Patient (yrs)";
run;

proc print Data = Seizure label;
run;

/** 1 Using PROC FREQ determine how many patients were randomized to the placebo and how many were randomized to the progabide treatment **/

proc freq data = Seizure;
table Trt;
run;

/** Answer: 28 patients in Placebo while 31 patients in Progabide **/

/** 2  Using PROC MEANS to answer - what are the N, MEAN and SD of seizure rate at baseline by treatment **/

proc means data = Seizure N Mean Std;
by Trt;
var BaseSeizure;
run;

/** Answer: For Placebo: N =28, Mean = 30.786, SD = 26.104  while for Progabide N =31, Mean = 31.613, SD = 27.981 **/

/** 3 Using PROC MEANS to find the mean, standard deviation & median seizure rates within each treatment group at each week following treatment **/

proc means data = Seizure N Mean Median;
by Trt;
var Seizure1 Seizure2 Seizure3 Seizure4;
run;

/** Answer: For Placebo: N =28 for all 4 Seizure counts,  
Mean = 9.36, 8.29, 8.79, 7.96  for Seizure counts 1-4 repectively
Median = 5,4.5,5,5 for Seizure counts 1-4 repectively

For Progabide N =31 for all 4 Seizure counts
Mean = 8.58, 8.42, 8.13, 6.71  for Seizure counts 1-4 repectively
Median = 4,5,4,4 for Seizure counts 1-4 repectively
**/

/** 4 Plot of the seizure rate at week 4 (Seizure4) vs the baseline seizure rate (BaseSeizure) for each treatment group **/

proc plot data=Seizure;
plot Seizure4*BaseSeizure = "*";
by Trt;
title "Seizure4 vs BaseSeizure";
run;

