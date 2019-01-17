
PROC IMPORT OUT= WORK.coil 
            DATAFILE= "C:\Users\akalia3\Downloads\S13.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data coil2;
set  coil ;
rand=ranuni(092765);
     if rand <=.7 then RespHoldout=.;
else if rand  >.7 then do;
   RespHoldout=Resp;
   Resp=.
   ;
end;
run;

data coil3;
set  coil2;
array orig[11](0, 1, 2,  3,  4,  5,   6,   7,    8,    9, 10);
array new[11] (0,25,75,150,350,750,3000,7500,15000,30000,30000);
retain orig1-orig10 new1-new10; 
do i=1 to dim(orig); 
 if pwapar=orig[i] then pwapar2=new[i];
 if PAANHA=orig[i] then PAANHA2=new[i];
 if PPERSA=orig[i] then PPERSA2=new[i];
end;
drop orig1--orig11 new1--new11 i; 
run;

proc freq data=coil3;
tables 	pwapar*pwapar2
		PAANHA*PAANHA2
		PPERSA*PPERSA2/list;
run;

data coil3;
set  coil3;
drop pwapar paanha ppersa;
run;




data coil4;
set  coil3;
array orig[11](0,  1, 2, 3, 4, 5, 6, 7, 8,  9, 10);
array new[11] (0,5.5,17,30,43,56,69,82,94,100,100);
retain orig1-orig10 new1-new10; 
do i=1 to dim(orig); 
if MGODRK =orig[i] then MGODRK2 =new[i];
if MGODPR =orig[i] then MGODPR2 =new[i];
if MRELGE =orig[i] then MRELGE2 =new[i];
if MFALLE =orig[i] then MFALLE2 =new[i];
if MFWEKI =orig[i] then MFWEKI2 =new[i];
if MOPLHO =orig[i] then MOPLHO2 =new[i];
if MSKA   =orig[i] then MSKA2 =new[i];
if MSKB1  =orig[i] then MSKB12 =new[i];
if MSKB2  =orig[i] then MSKB22 =new[i];
if MSKC   =orig[i] then MSKC2 =new[i];
if MHHUUR =orig[i] then MHHUUR2 =new[i];
if MAUT1  =orig[i] then MAUT12 =new[i];
if MAUT2  =orig[i] then MAUT22 =new[i];
if MAUT0  =orig[i] then MAUT02 =new[i];
if MINKGE =orig[i] then MINKGE2 =new[i];
end;
drop orig1--orig11 new1--new11 i; 
run;


proc freq data=coil4;
tables
MGODRK*MGODRK2
MGODPR*MGODPR2
MRELGE*MRELGE2
MFALLE*MFALLE2
MFWEKI*MFWEKI2
MOPLHO*MOPLHO2
MSKA*MSKA2
MSKB1*MSKB12
MSKB2*MSKB22
MSKC*MSKC2
MHHUUR*MHHUUR2
MAUT1*MAUT12
MAUT2*MAUT22
MAUT0*MAUT02
MINKGE*MINKGE2
/list;
run;


data coil5;
set  coil4;
drop
MGODRK
MGODPR
MRELGE
MFALLE
MFWEKI
MOPLHO
MSKA
MSKB1
MSKB2
MSKC
MHHUUR
MAUT1
MAUT2
MAUT0
MINKGE
;
run;

%CatToBinWithDrop(coil5,seqnum,mostyp);
%CatToBinWithDrop(coil5,seqnum,MOSHOO);

proc means data=coil5 n nmiss;
run;

data hold00;
set coil5;
if resp=.;
run;

data anal00;
set coil5;
if resp>.;
run;

PROC EXPORT DATA= WORK.ANAL00 
            OUTFILE= "C:\Users\akalia3\Desktop\Anal00.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
PROC EXPORT DATA= WORK.Hold00 
            OUTFILE= "C:\Users\akalia3\Desktop\Hold00.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

proc contents data=anal00;
run;
