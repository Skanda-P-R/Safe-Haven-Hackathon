IMPORT $;
Edu := $.File_Education.File;

Rec := RECORD
 Edu.State;
 Avg_Primary_Boys := ROUND(AVE(GROUP,Edu.Primary_Boys));
 Avg_Primary_Girls := ROUND(AVE(GROUP,Edu.Primary_Girls));
 Avg_Upper_Primary_Boys := ROUND(AVE(GROUP,Edu.Upper_Primary_Boys));
 Avg_Upper_Primary_Girls := ROUND(AVE(GROUP,Edu.Upper_Primary_Girls));
 Avg_Secondary_Boys := ROUND(AVE(GROUP,Edu.Secondary_Boys));
 Avg_Secondary_Girls := ROUND(AVE(GROUP,Edu.Secondary_Girls));
 Avg_Higher_Secondary_Boys := ROUND(AVE(GROUP,Edu.Higher_Secondary_Boys));
 Avg_Higher_Secondary_Girls := ROUND(AVE(GROUP,Edu.Higher_Secondary_Girls));
END;

Tab := SORT(TABLE(Edu,Rec,State),State);
//OUTPUT(Tab);

New_Rec := RECORD
 Tab.State;
 DECIMAL5_2 Avg_Student_Enrollment;
END;

New_Rec Calc_Avg(Tab Le) := TRANSFORM
 SELF.State := Le.State;
 SELF.Avg_Student_Enrollment := (Le.Avg_Primary_Boys + Le.Avg_Primary_Girls + Le.Avg_Upper_Primary_Boys + Le.Avg_Upper_Primary_Girls + Le.Avg_Secondary_Boys + Le.Avg_Secondary_Girls + Le.Avg_Higher_Secondary_Boys + Le.Avg_Higher_Secondary_Girls)/8;
END;

Final := SORT(PROJECT(Tab,Calc_Avg(LEFT)),State);

OUTPUT(Final,,'~pos::spr::Avg_Student_Enrollment',NAMED('Avg_Student_Enrollment'),OVERWRITE);