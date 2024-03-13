IMPORT $;

Education := $.File_Education.File;
OUTPUT(Education,NAMED('Education'));

Unemployment := $.File_Unemployment.File;
Out := Unemployment(State <> 'ï»¿0');
OUTPUT(Out,NAMED('Unemployment'));//ï»¿0

CPI := $.File_CPI.File;
OUTPUT(CPI,NAMED('CPI'));

Crime := $.File_crime.File;
OUTPUT(Crime,NAMED('Crime'));

Hos := $.File_hospitals.File;
OUTPUT(Hos,NAMED('Hospitals'));

pol := $.File_Police.File;
OUTPUT(pol,NAMED('Police_Stations'));

mon := $.File_Monuments.File;
OUTPUT(mon,NAMED('Monuments'));