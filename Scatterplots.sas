/* SAS Viz Tutorial: Scatterplots
PROC SGSCATTER, PROC SGPLOT, PROC CORR */

/* Use anscombe.sas7bdat dataset */
libname mydata '/home/charlotte.bourne/my_courses/donald.wedding/c_8888/PRED411/UNIT00'
access=readonly;


/* PROC CORR */
/* Use PROC CORR for Pearson correlation coefficients of (x, y) pairs */
/* Example of how high correlation != linear relationships */
title "PROC CORR Example: Anscombe Quartet";
ods graphics on;
PROC CORR DATA = mydata.anscombe;
	var x1;
	with y1;
	title2 "X1 and Y1 Correlation";
run;

PROC CORR DATA = mydata.anscombe;
	var x2;
	with y2;
	title2 "X2 and Y2 Correlation"
run;

PROC CORR DATA = mydata.anscombe;
	var x3;
	with y3;
	title2 "X3 and Y3 Correlation";
run;

PROC CORR DATA = mydata.anscombe;
	var x4;
	with y4;
	title2 "X4 and Y4 Correlation";
	run;
ods graphics off;


/* PROC SGPLOT */
title "PROC SGPLOT Example: Anscombe Quartet";
ods graphics on;
PROC SGPLOT DATA = mydata.anscombe;
	LOESS x=x1 y=y1 / nomarkers;;
	reg x=x1 y=y1;
	Title2 "X1 and Y1 Scatterplot with LOESS and Regression";
run;

PROC SGPLOT DATA = mydata.anscombe;
	LOESS x=x2 y=y2 / nomarkers;;
	reg x=x2 y=y2;
	Title2 "X2 and Y2 Scatterplot with LOESS and Regression";
	
run;PROC SGPLOT DATA = mydata.anscombe;
	LOESS x=x3 y=y3 / nomarkers;;
	reg x=x3 y=y3;
	Title2 "X3 and Y3 Scatterplot with LOESS and Regression";
	
run;PROC SGPLOT DATA = mydata.anscombe;
	LOESS x=x4 y=y4 / nomarkers;;
	reg x=x4 y=y4;
	Title2 "X4 and Y4 Scatterplot with LOESS and Regression";
run;
ods graphics off;


/* PROC SGSCATTER */
title "PROC SGSCATTER Example: Anscombe Quartet";
ods graphics on;
PROC SGSCATTER data=mydata.anscombe;
	compare x=x1 y=y1 / loess reg;
	Title2 "X1 and Y1 Scatter with Loess and Regression";
run;

PROC SGSCATTER data=mydata.anscombe;
	compare x=x2 y=y2 / loess reg;
	Title2 "X2 and Y2 Scatter with Loess and Regression";
run;

PROC SGSCATTER data=mydata.anscombe;
	compare x=x3 y=y3 / loess reg;
	Title2 "X3 and Y3 Scatter with Loess and Regression";
run;

PROC SGSCATTER data=mydata.anscombe;
	compare x=x4 y=y4 / loess reg;
	Title2 "X4 and Y4 Scatter with Loess and Regression";
run;
ods graphics off;
