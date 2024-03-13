IMPORT $;
Unemp := $.File_Unemployment.File;

New_Rec := RECORD
 Unemp.State;
 Unemp.Unemployment_Rate_in_2011_12;
 Unemp.Unemployment_Rate_in_2012_13;
 Unemp.Unemployment_Rate_in_2013_14;
 Unemp.Unemployment_Rate_in_2015_16;
 Unemp.Unemployment_Rate_in_2017_18;
 Unemp.Unemployment_Rate_in_2018_19;
 Unemp.Unemployment_Rate_in_2019_20;
 DECIMAL3_1 Avg_Unemp := 0;
END;

Tab := TABLE(Unemp,New_Rec);

//OUTPUT(Tab);

New_Rec Calc(New_Rec Le) := TRANSFORM
 SELF.State := Le.State;
 SELF.Unemployment_Rate_in_2011_12 := Le.Unemployment_Rate_in_2011_12;
 SELF.Unemployment_Rate_in_2012_13 := Le.Unemployment_Rate_in_2012_13;
 SELF.Unemployment_Rate_in_2013_14 := Le.Unemployment_Rate_in_2013_14;
 SELF.Unemployment_Rate_in_2015_16 := Le.Unemployment_Rate_in_2015_16;
 SELF.Unemployment_Rate_in_2017_18 := Le.Unemployment_Rate_in_2017_18;
 SELF.Unemployment_Rate_in_2018_19 := Le.Unemployment_Rate_in_2018_19;
 SELF.Unemployment_Rate_in_2019_20 := Le.Unemployment_Rate_in_2019_20;
 SELF.Avg_Unemp := (Le.Unemployment_Rate_in_2011_12 + 
                    Le.Unemployment_Rate_in_2012_13 + 
                    Le.Unemployment_Rate_in_2013_14 + 
                    Le.Unemployment_Rate_in_2015_16 + 
                    Le.Unemployment_Rate_in_2017_18 + 
                    Le.Unemployment_Rate_in_2018_19 + 
                    Le.Unemployment_Rate_in_2019_20)/7;
END;

Final := SORT(PROJECT(Tab,Calc(LEFT)),State);

OUTPUT(Final,,'~pos::spr::unemp',NAMED('Average_Unemployment'),OVERWRITE);