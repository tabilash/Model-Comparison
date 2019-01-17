PROC IMPORT OUT= WORK.FromR 
            DATAFILE= "C:\Users\akalia3\Desktop\test.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc freq data=FromR;
tables resp;
run;
*If this doesnt match your mid-term memo then contact me.  SAS read in your file wrong;

proc means data=work.FromR nmiss mean std cv p1 p10 p25 p50 p75 p90 p99;
var treepred marspred rf;
run;


data treeanal;
set  FromR;
keep treepred resp;
run;
proc sort data=treeanal;
by descending treepred;
run;
data treeanal2;
set  treeanal;
treecumresp+resp;
treepct=treecumresp/96;
run;

data Forestanal;
set  FromR;
keep rf resp;
run;
proc sort data=Forestanal;
by descending rf;
run;
data Forestanal2;
set  Forestanal;
Forestcumresp+resp;
Forestpct=Forestcumresp/96;
run;


data Marsanal;
set  FromR;
keep marspred resp;
run;
proc sort data=Marsanal;
by descending marspred;
run;
data Marsanal2;
set  Marsanal;
Marscumresp+resp;
Marspct=Marscumresp/96;
run;

data  compare;
merge ForestAnal2 
      MarsAnal2
	 TreeAnal2
	 RespAnal
	 ;
run;
