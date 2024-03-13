IMPORT $;

rec :=RECORD
STRING State;
UNSIGNED hospital_count;
UNSIGNED Hospital_Score := 0;
END;

ds := SORT(DATASET('~pos::spr::Analyse_Hospital',rec,THOR),-hospital_count);

rec Calc(rec Le,rec Ri) := TRANSFORM
 SELF.Hospital_Score := IF(Le.hospital_count = Ri.hospital_count,Le.Hospital_Score,Le.Hospital_Score+1);
 SELF := Ri;
END;

final := SORT(ITERATE(ds,Calc(LEFT,RIGHT)),State);

OUTPUT(final,,'~pos::spr::Hospital_scores',NAMED('Hospital_Scores'),OVERWRITE);