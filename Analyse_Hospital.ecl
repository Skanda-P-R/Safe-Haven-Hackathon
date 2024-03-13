IMPORT $;

ds := $.File_hospitals.File;

rec := RECORD
ds.state;
UNSIGNED Hospital_count := COUNT(GROUP);
END;

tb := TABLE(ds,rec,state)(state<>'');

OUTPUT(tb,,'~pos::spr::Analyse_Hospital',NAMED('Analyse_Hospitals'),OVERWRITE);