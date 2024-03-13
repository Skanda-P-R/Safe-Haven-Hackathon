IMPORT LinearRegression AS LR;
IMPORT ML_Core;
IMPORT ML_Core.Types as Types;
IMPORT $;

rec := RECORD
    STRING state;
    REAL hot_spot_score;
    REAL poverty_score;
    REAL avg_student_enrollment;
    REAL education_score;
    REAL avg_unemp;
    REAL unemp_score;
    REAL average_cpi_2011_2020;
    REAL cpi_score;
    REAL avg_cases_total;
    REAL crime_score;
END;
 
DSA := DATASET('~pos::spr::hot_spot_scores',rec,CSV);

rec1 := RECORD
  REAL Avg_Student_Enrollment;
  REAL Avg_Unemp;
  REAL Average_CPI_2011_2020;
  REAL Avg_Cases_Total;
END;

EXPORT Predict_Hot(DATASET(rec1) df) := MODULE
 
 Tab_Y_Rec := RECORD
  DSA.hot_spot_score;
 END;
 
 Tab_Y_Train := PROJECT(DSA, Tab_Y_Rec);

 Tab_X_Rec := RECORD
 DSA.Avg_Student_Enrollment;
 DSA.Avg_Unemp;
 DSA.Average_CPI_2011_2020;
 DSA.Avg_Cases_Total;
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