
IMPORT $;
IMPORT LinearRegression AS LR;
IMPORT ML_Core;
IMPORT ML_Core.Types as Types;

Rec := RECORD
  STRING17 State;
  REAL Poverty_Score;
  REAL Avg_Student_Enrollment;
  REAL Education_Score;
  REAL Avg_Unemp;
  REAL Unemp_Score;
  REAL Average_CPI_2011_2020;
  REAL CPI_Score;
END;

DSA := DATASET('pos::spr::Poverty_Scores',Rec,THOR);

Tab_Y_Rec := RECORD
 DSA.Poverty_Score;
END;

Tab1 := TABLE(DSA,Tab_Y_Rec,Poverty_Score);

Tab_Y_Train := PROJECT(DSA[1..23], Tab_Y_Rec);
Tab_Y_Test := PROJECT(DSA[24..], Tab_Y_Rec);

Tab_X_Rec := RECORD
 DSA.Avg_Student_Enrollment;
 DSA.Avg_Unemp;
 DSA.Average_CPI_2011_2020;
END;

Tab_2 := TABLE(DSA,Tab_X_Rec);

Tab_X_Train := PROJECT(DSA[1..23], Tab_X_Rec);
Tab_X_Test := PROJECT(DSA[24..], Tab_X_Rec);

ML_Core.AppendSeqId(Tab_Y_Train, id,Tab_Y_Train_ID);
ML_Core.AppendSeqId(Tab_Y_Test, id,Tab_Y_Test_ID);
ML_Core.AppendSeqId(Tab_X_Train, id,Tab_X_Train_ID);
ML_Core.AppendSeqId(Tab_X_Test, id,Tab_X_Test_ID);

ML_Core.ToField(Tab_Y_Train_ID, Tab_Y_Train_NF);
ML_Core.ToField(Tab_Y_Test_ID, Tab_Y_Test_NF);
ML_Core.ToField(Tab_X_Train_ID, Tab_X_Train_NF);
ML_Core.ToField(Tab_X_Test_ID, Tab_X_Test_NF);

//Analysis and Prediction

Train := LR.OLS(Tab_X_Train_NF,Tab_Y_Train_NF);
MyModel := Train.GetModel;

Betas   := Train.Betas();
OUTPUT(Betas,NAMED('Betas'));

MyPredict := Train.Predict(Tab_X_Test_NF,MyModel);
OUTPUT(MyPredict,NAMED('Poverty_Score_Prediction'));

Test_Result := RECORD
  REAL Test_Score;
  REAL Predicted_Score;
  REAL Difference;
 END;
 
NumericField := Types.NumericField;
Test_Result Format_Result(NumericField Le, NumericField Ri) := TRANSFORM
  SELF.Test_Score := Le.value;
  SELF.Predicted_Score := Ri.value;
  SELF.Difference := ABS(SELF.Test_Score - SELF.Predicted_Score);
 END;
 
Result := JOIN(Tab_Y_Test_NF, MyPredict, LEFT.id=RIGHT.id, Format_Result(LEFT, RIGHT));
OUTPUT(SORT(Result,Test_Score),NAMED('Predicted_Accuracy'));

//More ANALYSIS

//R Squared - R Squared generally varies between 0 and 1, 
//with 1 indicating an exact linear fit, and 0 indicating that a
//linear fit will have no predictive power
Rsq := Train.RSquared;
OUTPUT(Rsq,NAMED('RSquared_Value'));

//pval - Probablility
pValue := Train.pval;
OUTPUT(pValue,NAMED('Probablility_Value'));