IMPORT $;

ds := $.File_Police.File;

rec := RECORD
ds.state;
Avg_PH_Houses_Provided_by_Department := ROUND(AVE(GROUP,ds.PH_Houses_Provided_by_Department));
Avg_PH_Houses_provided_on_LeaseRentGPRA := ROUND(AVE(GROUP,ds.PH_Houses_provided_on_LeaseRentGPRA));
Avg_PH_Sanctioned_Strength := ROUND(AVE(GROUP,ds.PH_Sanctioned_Strength));
UNSIGNED Avg_Police_Houses_Total := 0
END;

tb := TABLE(ds,rec,state);

// OUTPUT(tb);

rec test(rec Le) := TRANSFORM
SELF.Avg_Police_Houses_Total := (Le.Avg_PH_Houses_Provided_by_Department+Le.Avg_PH_Houses_provided_on_LeaseRentGPRA+Le.Avg_PH_Sanctioned_Strength)/3;
SELF := Le;
END;

proj := PROJECT(tb,test(LEFT));

final_rec := RECORD
proj.state;
proj.Avg_Police_Houses_Total;
END;

final := TABLE(proj,final_rec,state,Avg_Police_Houses_Total);

OUTPUT(final,,'~pos::spr::Analyse_Police',NAMED('Avg_Police_Houses'),OVERWRITE);