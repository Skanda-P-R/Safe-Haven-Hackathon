IMPORT $;

EXPORT Hot_Spot_Prediction() := FUNCTION

 STRING Enroll := '' : STORED('Enrollment_Ratio');
 STRING Unemp := '' : STORED('Average_Unemployment');
 STRING CPI := '' : STORED('Average_CPI');
 STRING Crime := '' : STORED('Number_of_Crimes');
 
 rec := RECORD
  REAL Avg_Student_Enrollment;
  REAL Avg_Unemp;
  REAL Average_CPI_2011_2020;
  REAL Avg_Cases_Total;
 END;
 
 df := DATASET([{Enroll,Unemp,CPI,Crime}],rec);
 
 final := $.Predict_Hot(df).My_Predict;
 
 RETURN OUTPUT(final, {Predicted_Hot_Spot_Score := ROUND(value)});
 
 END;