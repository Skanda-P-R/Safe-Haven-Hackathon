IMPORT $;

ds := $.File_crime.File;

rec := RECORD
ds.state;
Avg_K_A_Cases_Reported := ROUND(AVE(GROUP,ds.K_A_Cases_Reported));
Avg_K_A_Female_10_15_Years := ROUND(AVE(GROUP,ds.K_A_Female_10_15_Years));
Avg_K_A_Female_15_18_Years := ROUND(AVE(GROUP,ds.K_A_Female_15_18_Years));
Avg_K_A_Female_18_30_Years := ROUND(AVE(GROUP,ds.K_A_Female_18_30_Years));
Avg_K_A_Female_30_50_Years := ROUND(AVE(GROUP,ds.K_A_Female_30_50_Years));
Avg_K_A_Female_Above_50_Years := ROUND(AVE(GROUP,ds.K_A_Female_Above_50_Years));
Avg_K_A_Female_Total := ROUND(AVE(GROUP,ds.K_A_Female_Total));
Avg_K_A_Female_Upto_10_Years := ROUND(AVE(GROUP,ds.K_A_Female_Upto_10_Years));
Avg_K_A_Grand_Total := ROUND(AVE(GROUP,ds.K_A_Grand_Total));
Avg_K_A_Male_10_15_Years := ROUND(AVE(GROUP,ds.K_A_Male_10_15_Years));
Avg_K_A_Male_15_18_Years := ROUND(AVE(GROUP,ds.K_A_Male_15_18_Years));
Avg_K_A_Male_18_30_Years := ROUND(AVE(GROUP,ds.K_A_Male_18_30_Years));
Avg_K_A_Male_30_50_Years := ROUND(AVE(GROUP,ds.K_A_Male_30_50_Years));
Avg_K_A_Male_Above_50_Years := ROUND(AVE(GROUP,ds.K_A_Male_Above_50_Years));
Avg_K_A_Male_Total := ROUND(AVE(GROUP,ds.K_A_Male_Total));
Avg_K_A_Male_Upto_10_Years := ROUND(AVE(GROUP,ds.K_A_Male_Upto_10_Years));
REAL Avg_Cases_Total := 0
END;

tb := TABLE(ds,rec,state);

// OUTPUT(tb);

rec test(rec Le) := TRANSFORM
SELF.Avg_Cases_Total := (Le.Avg_K_A_Cases_Reported+Le.Avg_K_A_Female_10_15_Years+Le.Avg_K_A_Female_15_18_Years+Le.Avg_K_A_Female_18_30_Years+Le.Avg_K_A_Female_30_50_Years+Le.Avg_K_A_Female_Above_50_Years+Le.Avg_K_A_Female_Total+Le.Avg_K_A_Female_Upto_10_Years+Le.Avg_K_A_Grand_Total+Le.Avg_K_A_Male_10_15_Years+Le.Avg_K_A_Male_15_18_Years+Le.Avg_K_A_Male_18_30_Years+Le.Avg_K_A_Male_30_50_Years+Le.Avg_K_A_Male_Above_50_Years+Le.Avg_K_A_Male_Total+Le.Avg_K_A_Male_Upto_10_Years)/16;
SELF := Le;
END;

proj := PROJECT(tb,test(LEFT));

final_rec := RECORD
proj.state;
proj.Avg_Cases_Total;
END;

final := TABLE(proj,final_rec,state,Avg_Cases_Total);

OUTPUT(final,,'pos::spr::Analyse_Crime',NAMED('Avg_Crime'),OVERWRITE);