IMPORT LinearRegression AS LR;
IMPORT ML_Core;
IMPORT ML_Core.Types as Types;
IMPORT $;

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
 
DSA := DATASET('~pos::spr::safe_haven_scores',rec,CSV);

rec1 := RECORD
REAL Numbers_of_Monuments;
REAL Hospital_count;
REAL Avg_Police_Houses_total;
END;

EXPORT Predict_Safe(DATASET(rec1) df) := MODULE

 Tab_Y_Rec := RECORD
  DSA.Safe_Haven_Score;
 END;

 Tab_Y_Train := PROJECT(DSA, Tab_Y_Rec);

 Tab_X_Rec := RECORD
  DSA.Numbers_of_Monuments;
  DSA.Hospital_count;
  DSA.Avg_Police_Houses_total;
 END;

 Tab_X_Train := PROJECT(DSA, Tab_X_Rec);

 ML_Core.AppendSeqId(Tab_Y_Train, id,Tab_Y_Train_ID);
 ML_Core.AppendSeqId(Tab_X_Train, id,Tab_X_Train_ID);
 ML_Core.ToField(Tab_Y_Train_ID, Tab_Y_Train_NF);
 ML_Core.ToField(Tab_X_Train_ID, Tab_X_Train_NF);
 
 Train := LR.OLS(Tab_X_Train_NF,Tab_Y_Train_NF);
 My_Model := Train.GetModel;
 
 ML_Core.AppendSeqId(df, id,InDSA_ID);
 ML_Core.ToField(InDSA_ID, X_Test);
 
 EXPORT My_Predict := Train.Predict(X_Test,My_Model);
 
 END;