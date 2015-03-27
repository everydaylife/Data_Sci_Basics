/* SAS DataStep Tutorial: The Basics
Data set creation, read back, and manipulations*/


/* Create data sets */
data temp1;
length dimkey $2;
length x 8.0;
length y 8.0;
input dimkey $ x y;
datalines;
01 100 12.2 
02 300 7.45 
03 200 10.0 
04 500 5.67 
05 300 4.55
;
run;

data temp2;
length dimkey $2;
length z 8.0;
length first_name $10;
length last_name $10;
input dimkey $ z first_name $ last_name $;
datalines;
01 100 steve miller 
02 300 Steve Utrup 
04 500 JacK wilsoN 
05 300 AbRAham LINcoln 
06 100 JackSON SmiTH 
07 200 EarL Campbell 
08 400 WiLLiam Right
;
run;


/* Print data sets */
title 'Data = temp1';
proc print data=temp1; run; quit;

title 'Data = temp2';
proc print data=temp2; run; quit;


/* List variable names and meta data */
title;
proc contents data=temp1; run; quit;

title
proc contents data=temp2; run; quit;


/* Common SAS manipulations
Casing, Subsetting, Compressing Fields */
data temp1;
	set temp1;
	w = 2*y +1;
	if (x < 150) then segment=1;
	else if (x < 250) then segment=2;
	else segment=3;
run;

data temp2;
	set temp2;
	proper_first_name = propcase(first_name);
	upper_last_name = upcase(last_name);
	first_initial = substr(upcase(first_name), 1, 1);
	last_initial = substr(upcase(last_name), 1, 1);
	initials = compress(first_initial|last_initial);
run;

title 'Data = temp1';
proc print data=temp1; run; quit;

title 'Data = temp2'; 
proc print data=temp2(obs=15); run; quit; 


/* Subsetting Data */
data s1;
	set temp1;
	if (segment = 1);
run;

data s2; 
	set temp1;
	if (segment ne 1) then delete;
run;

/* Works but not proper */
data s3;
	set temp1;
	where (segment = 1);
run;

/* A where clause really should be in this statement */
data s4;
	set temp1 (where = (segment = 1));
run;

/* Check the datasets; should be identical if above syntax is correct */
title;
proc print data = s1; run; quit;
proc print data = s2; run; quit;
proc print data = s3; run; quit;
proc print data = s4; run; quit;


/* Ways of combining data sets */

/* Stacking data sets */
data stacked_data;
	set temp1 temp2;
run;

title 'Data = stacked_data';
proc print data = stacked_data; run; quit;

/* Ordered stack */
/* First: sort by dimkey */
proc sort data = temp1; by dimkey; run; quit;
proc sort data = temp2; by dimkey; run; quit; 

/* Second: order stack using BY statement */
data ordered_stack;
	set temp1 temp2;
	by dimkey;
run;

title 'Data = ordered_stack';
proc print data = ordered_stack; run; quit;

/* Combine columns using MERGE into one dataset */
/* Data is already sorted and must be sorted for this to work */
data merged_data;
	merge temp1 temp2;
	by dimkey;
run;

title 'Data = merged_data';
proc print data = merged_data; run; quit;

/* SQL operations in SAS using IN statement */
/* Data must be sorted */
/* LEFT JOIN */
title 'LEFT JOIN OUTPUT';
data left_join;
	merge temp1 (in=a) temp2 (in=b);
	by dimkey;
	if (a=1);
run;

proc print data=left_join; run; quit;

/* RIGHT JOIN */
title 'RIGHT JOIN OUTPUT';
data right_join;
	merge temp1 (in=a) temp2 (in=b);
	by dimkey;
	if (b=1);
run;

proc print data=right_join; run; quit;

/* INNER JOIN */
title 'INNER JOIN OUTPUT';
data inner_join;
	merge temp1 (in=a) temp2 (in=b)
	by dimkey;
	if (a=1) and (b=1);
run;

proc print data=inner_join; run; quit;


/* Note: SAS Studio cannot use INFILE Statements
Can only use data on the server, read in with cards, or pushed to server through JMP */


