IMPORT $,STD;

rec := RECORD
  STRING17 State;
  REAL Safe_Haven_Score;
  REAL Hot_Spot_Score;
  REAL Numbers_of_Monuments;
  REAL Monuments_Score;
  REAL Hospital_count;
  REAL Hospital_Score;
  REAL Avg_Police_Houses_total;
  REAL Police_Score;
END;

ds := DATASET('~hthor::pos::spr::safe_haven_scores',rec,THOR);

EXPORT Safe_Haven_Search() := FUNCTION

 STRING sta := '' : STORED('Enter_State_Name');
 RETURN (ds((STD.str.Find(State, sta,1) <> 0)));
 
END;