IMPORT $;

Edu_DS := $.File_Combine.Edu_Score_DS;
Unemp_DS := $.File_Combine.Unemp_Score_DS;
CPI_DS := $.File_Combine.CPI_Score_DS;
All_Layout := $.File_Combine.Layout;

Edu_Unemp := JOIN(Edu_Ds,Unemp_DS,LEFT.State=RIGHT.State,
                  TRANSFORM(All_Layout,
                  SELF.Avg_Unemp := RIGHT.Avg_Unemp,
                  SELF.Unemp_Score := RIGHT.Unemp_Score,
                  SELF := LEFT),
                  LOOKUP);

Edu_Unemp_CPI := JOIN(Edu_Unemp,CPI_DS,LEFT.State=RIGHT.State,
                      TRANSFORM(All_Layout,
                      SELF.Average_CPI_2011_2020 := RIGHT.Average_CPI_2011_2020,
                      SELF.CPI_Score := RIGHT.CPI_Score,
                      SELF := LEFT),
                      LOOKUP);

All_Layout Score(Edu_Unemp_CPI Le) := TRANSFORM
 SELF.Poverty_Value := Le.Education_Score + Le.Unemp_Score + Le.CPI_Score;
 SELF := Le;
END;

Poverty_Value_DS := SORT(PROJECT(Edu_Unemp_CPI,Score(LEFT)),Poverty_Value);

All_Layout Pov_Score(Poverty_Value_DS Le,Poverty_Value_DS Ri) := TRANSFORM
 SELF.Poverty_Score := IF(Le.Poverty_Value = Ri.Poverty_Value,Le.Poverty_Score,Le.Poverty_Score+1);
 SELF := Ri;
END;

Poverty_Score_DS := ITERATE(Poverty_Value_DS,Pov_Score(LEFT,RIGHT));

Final_Rec := RECORD
 Poverty_Score_DS.State;
 Poverty_Score_DS.Poverty_Score;
 Poverty_Score_DS.Avg_Student_Enrollment;
 Poverty_Score_DS.Education_Score;
 Poverty_Score_DS.Avg_Unemp;
 Poverty_Score_DS.Unemp_Score;
 Poverty_Score_DS.Average_CPI_2011_2020;
 Poverty_Score_DS.CPI_Score;
END;

Final := SORT(TABLE(Poverty_Score_DS,Final_Rec),State);

OUTPUT(Final,,'pos::spr::poverty_scores',NAMED('Poverty_Scores'),OVERWRITE);