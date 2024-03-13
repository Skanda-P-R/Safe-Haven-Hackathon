EXPORT File_Combine := MODULE

 //Education
 
 EXPORT Edu_Score_Rec := RECORD
  STRING17 State;
  REAL Avg_Student_Enrollment;
  REAL Education_Score;
 END;
 
 EXPORT Edu_Score_DS := DATASET('~pos::spr::Edu_Scores',Edu_Score_Rec,FLAT);
 
 //Unemployment
 
 EXPORT Unemp_Score_Rec := RECORD
  STRING17 State;
  REAL Avg_Unemp;
  REAL Unemp_Score;
 END;
 
 EXPORT Unemp_Score_DS := DATASET('pos::spr::unemployment_score',Unemp_Score_Rec,FLAT);
 
 //CPI
 
 EXPORT CPI_Score_Rec := RECORD
  STRING17 State;
  REAL Average_CPI_2011_2020;
  REAL CPI_Score;
 END;
 
 EXPORT CPI_Score_DS := DATASET('pos::spr::cpi_scores',CPI_Score_Rec,FLAT);
 
 //Crime
 
 EXPORT Crime_Score_Rec := RECORD
  STRING17 State;
  REAL Avg_Cases_Total;
  UNSIGNED Crime_Score;
 END;
 
 EXPORT Crime_Score_DS := DATASET('~pos::spr::Crime_scores',Crime_Score_Rec,THOR);
 
 //Hospital
 
 EXPORT Hospital_Score_Rec := RECORD
  STRING17 State;
  UNSIGNED hospital_count;
  UNSIGNED Hospital_Score;
 END;
 
 EXPORT Hospital_Score_DS := DATASET('~pos::spr::Hospital_scores',Hospital_Score_Rec,THOR);
 
 //Monuments
 
 EXPORT Monuments_Score_Rec := RECORD
  STRING State;
  UNSIGNED numbers_of_monuments;
  UNSIGNED Monuments_Score;
 END;
 
 EXPORT Monuments_Score_DS := DATASET('~pos::spr::Monuments_scores',Monuments_Score_Rec,THOR);
 
 //Police
 
 EXPORT Police_Score_Rec := RECORD
  STRING State;
  UNSIGNED avg_police_houses_total;
  UNSIGNED Police_Score;
 END;
 
 EXPORT Police_Score_DS := DATASET('~pos::spr::Police_scores',Police_Score_Rec,THOR);
 
 //Hot_Spot Layout
 
 EXPORT Hot_Spot_Rec := RECORD
  STRING17 State;
  REAL Hot_Spot_Value := 0;
  REAL Hot_Spot_Score := 0;
  REAL Avg_Student_Enrollment := 0;
  REAL Education_Score := 0;
  REAL Avg_Unemp := 0;
  REAL Unemp_Score := 0;
  REAL Average_CPI_2011_2020 := 0;
  REAL CPI_Score := 0;
  REAL Avg_Cases_Total := 0;
  REAL Crime_Score := 0;
  REAL Poverty_Value := 0;
  REAL Poverty_Score := 0;
 END;
 
 //Safe_Haven Layout
 
 EXPORT Safe_Haven_Rec := RECORD
  STRING17 State;
  REAL Safe_Haven_Value := 0;
  REAL Safe_Haven_Score := 0;
  REAL Hot_Spot_Score := 0;
  REAL hospital_count := 0;
  REAL Hospital_Score := 0;
  REAL Avg_Police_Houses_total := 0;
  REAL Police_Score := 0;
  REAL Numbers_of_Monuments := 0;
  REAL Monuments_Score := 0;
 END;
 
END;