IMPORT $;

Rec := RECORD
 STRING25 State;
 DECIMAL5_2 Avg_Student_Enrollment;
END;

Edu := DATASET('~pos::spr::Avg_Student_Enrollment',Rec,FLAT);

Score_Rec := RECORD
 Edu.State;
 Edu.Avg_Student_Enrollment;
 UNSIGNED2 Education_Score := 0;
END;

Tab := TABLE(Edu,Score_Rec);

//If Avg_Student_Enrollment is less for a state, then it should have lower Education score since it is a reason for poverty

Sort_Tab := SORT(Tab,Avg_Student_Enrollment);

Score_Rec Score(Sort_Tab Le,Sort_Tab Ri) := TRANSFORM
 SELF.Education_Score := IF(Le.Avg_Student_Enrollment=Ri.Avg_Student_Enrollment,Le.Education_Score,Le.Education_Score+1);
 SELF := Ri;
END;

Score_Table:= ITERATE(Sort_Tab,Score(LEFT,RIGHT));

//OUTPUT(Score_Table);

Final := SORT(Score_Table,State);

OUTPUT(Final,,'~pos::spr::Edu_Scores',NAMED('Education_Scores'),OVERWRITE);