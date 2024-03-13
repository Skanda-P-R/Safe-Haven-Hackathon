IMPORT $;

Edu_DS := $.File_Combine.Edu_Score_DS;
Unemp_DS := $.File_Combine.Unemp_Score_DS;
CPI_DS := $.File_Combine.CPI_Score_DS;
Crime_DS := $.File_Combine.Crime_Score_DS;
Hospital_DS := $.File_Combine.Hospital_Score_DS;
Monument_DS := $.File_Combine.Monuments_Score_DS;
Police_DS := $.File_Combine.Police_Score_DS;
Hot_Spot_Rec := $.File_Combine.Hot_Spot_Rec;
Safe_Haven_Rec := $.File_Combine.Safe_Haven_Rec;

Edu_Unemp := JOIN(Edu_Ds,Unemp_DS,LEFT.State=RIGHT.State,
                  TRANSFORM(Hot_Spot_Rec,
                  SELF.Avg_Unemp := RIGHT.Avg_Unemp,
                  SELF.Unemp_Score := RIGHT.Unemp_Score,
                  SELF := LEFT),
                  LOOKUP);

Edu_Unemp_CPI := JOIN(Edu_Unemp,CPI_DS,LEFT.State=RIGHT.State,
                      TRANSFORM(Hot_Spot_Rec,
                      SELF.Average_CPI_2011_2020 := RIGHT.Average_CPI_2011_2020,
                      SELF.CPI_Score := RIGHT.CPI_Score,
                      SELF := LEFT),
                      LOOKUP);

Hot_spot := JOIN(Edu_Unemp_CPI,Crime_DS,LEFT.State=RIGHT.State,
                      TRANSFORM(Hot_Spot_Rec,
                      SELF.Avg_Cases_Total := RIGHT.Avg_Cases_Total,
                      SELF.Crime_Score := RIGHT.Crime_Score,
                      SELF := LEFT),
                      LOOKUP);

Hot_Spot_Rec Score1(Hot_spot Le) := TRANSFORM
 SELF.Poverty_Value := Le.Education_Score + Le.Unemp_Score + Le.CPI_Score;
 SELF.Hot_Spot_Value := Le.Education_Score + Le.Unemp_Score + Le.CPI_Score + Le.Crime_Score;
 SELF := Le;
END;

Hot_Spot_Value_DS := SORT(PROJECT(Hot_spot,Score1(LEFT)),Hot_Spot_Value);

Hot_Spot_Rec Hot_Score(Hot_Spot_Value_DS Le,Hot_Spot_Value_DS Ri) := TRANSFORM
 SELF.Poverty_Score := IF(Le.Poverty_Value = Ri.Poverty_Value,Le.Poverty_Score,Le.Poverty_Score+1);
 SELF.Hot_Spot_Score := IF(Le.Hot_Spot_Value = Ri.Hot_Spot_Value,Le.Hot_Spot_Score,Le.Hot_Spot_Score+1);
 SELF := Ri;
END;

Hot_Spot_Score_DS := ITERATE(Hot_Spot_Value_DS,Hot_Score(LEFT,RIGHT));

Final_Hot_Rec := RECORD
 Hot_Spot_Score_DS.State;
 Hot_Spot_Score_DS.Hot_Spot_Score;
 Hot_Spot_Score_DS.Poverty_Score;
 Hot_Spot_Score_DS.Avg_Student_Enrollment;
 Hot_Spot_Score_DS.Education_Score;
 Hot_Spot_Score_DS.Avg_Unemp;
 Hot_Spot_Score_DS.Unemp_Score;
 Hot_Spot_Score_DS.Average_CPI_2011_2020;
 Hot_Spot_Score_DS.CPI_Score;
 Hot_Spot_Score_DS.Avg_Cases_Total;
 Hot_Spot_Score_DS.Crime_Score;
END;

Final_Hot_Spot := SORT(TABLE(Hot_Spot_Score_DS,Final_Hot_Rec),State);

OUTPUT(Final_Hot_Spot,,'pos::spr::hot_spot_scores',NAMED('Hot_Spot_Scores'),OVERWRITE);

Hospital_Monument := JOIN(Hospital_DS,Monument_DS,LEFT.State=RIGHT.State,
                  TRANSFORM(Safe_Haven_Rec,
                  SELF.numbers_of_monuments := RIGHT.numbers_of_monuments,
                  SELF.Monuments_Score := RIGHT.Monuments_Score,
                  SELF := LEFT),
                  LOOKUP);
                  
Hospital_Monument_Police := JOIN(Hospital_Monument,Police_DS,LEFT.State=RIGHT.State,
                  TRANSFORM(Safe_Haven_Rec,
                  SELF.avg_police_houses_total := RIGHT.avg_police_houses_total,
                  SELF.Police_Score := RIGHT.Police_Score,
                  SELF := LEFT),
                  LOOKUP);
                  
Safe := JOIN(Hospital_Monument_Police,Final_Hot_Spot,LEFT.State=RIGHT.State,
                  TRANSFORM(Safe_Haven_Rec,
                  SELF.Hot_Spot_Score := RIGHT.Hot_Spot_Score,
                  SELF := LEFT),
                  LOOKUP);
                  
Safe_Haven_Rec Score2(Safe Le) := TRANSFORM
 SELF.Safe_Haven_Value := Le.Hospital_Score + Le.Monuments_Score + Le.Police_Score;
 SELF := Le;
END;

Safe_Haven_Value_DS := SORT(PROJECT(Safe,Score2(LEFT)),Safe_Haven_Value);

Safe_Haven_Rec Safe_Score(Safe_Haven_Value_DS Le,Safe_Haven_Value_DS Ri) := TRANSFORM
 SELF.Safe_Haven_Score := IF(Le.Safe_Haven_Value = Ri.Safe_Haven_Value,Le.Safe_Haven_Score,Le.Safe_Haven_Score+1);
 SELF := Ri;
END;

Safe_Haven_Score_DS := ITERATE(Safe_Haven_Value_DS,Safe_Score(LEFT,RIGHT));

Final_Safe_Rec := RECORD
 Safe_Haven_Score_DS.State;
 Safe_Haven_Score_DS.Safe_Haven_Score;
 Safe_Haven_Score_DS.Hot_Spot_Score;
 Safe_Haven_Score_DS.Numbers_of_Monuments;
 Safe_Haven_Score_DS.Monuments_Score;
 Safe_Haven_Score_DS.Hospital_count;
 Safe_Haven_Score_DS.Hospital_Score;
 Safe_Haven_Score_DS.Avg_Police_Houses_Total;
 Safe_Haven_Score_DS.Police_Score;
END;

Final_Safe_Haven := SORT(TABLE(Safe_Haven_Score_DS,Final_Safe_Rec),State);

OUTPUT(Final_Safe_Haven,,'pos::spr::safe_haven_scores',NAMED('Safe_Haven_Scores'),OVERWRITE);