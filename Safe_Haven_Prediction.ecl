IMPORT $;

EXPORT Safe_Haven_Prediction() := FUNCTION

 STRING Monu := '' : STORED('Number_of_Monuments');
 STRING Hos := '' : STORED('Number_of_Hospitals');
 STRING Pol := '' : STORED('Number_of_Polce_Houses');
 
 rec := RECORD
 REAL Numbers_of_Monuments;
 REAL Hospital_count;
 REAL Avg_Police_Houses_total;
 END;
 
 df := DATASET([{Monu,Hos,Pol}],rec);
 
 final := $.Predict_Safe(df).My_Predict;
 
 RETURN OUTPUT(final, {Predicted_Safe_Haven_Score := ROUND(value)});
 
 END;