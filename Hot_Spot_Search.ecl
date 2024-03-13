IMPORT $,STD;

rec := RECORD
  STRING17 State;
  REAL Hot_Spot_Score;
  REAL Poverty_Score;
  REAL Avg_Student_Enrollment;
  REAL Education_Score;
  REAL Avg_Unemp;
  REAL Unemp_Score;
  REAL Average_CPI_2011_2020;
  REAL CPI_Score;
  REAL Avg_Cases_Total;
  REAL Crime_Score;
END;

ds := DATASET('~hthor::pos::spr::hot_spot_scores',rec,THOR);

EXPORT Hot_Spot_Search() := FUNCTION

 STRING sta := '' : STORED('Enter_State_Name');
 RETURN (ds((STD.str.Find(State, sta,1) <> 0)));
 
END;