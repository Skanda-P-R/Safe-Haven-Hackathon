IMPORT $;

ds := $.File_Monuments.File;

rec := RECORD
ds.state;
ds.numbers_of_monuments;
END;

tb := TABLE(ds,rec,state);

OUTPUT(tb,,'~pos::spr::Analyse_Monumetents',NAMED('Number_of_monuments'),OVERWRITE);