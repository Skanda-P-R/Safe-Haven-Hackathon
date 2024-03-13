IMPORT $;

rec :=RECORD
STRING State;
REAL Avg_Cases_Total;
UNSIGNED Crime_Score := 0;
END;

ds := SORT(DATASET('~thor::pos::spr::Analyse_Crime',rec,THOR),-Avg_Cases_Total);

rec Calc(rec Le,rec Ri) := TRANSFORM
 SELF.Crime_Score := IF(Le.Avg_Cases_Total = Ri.Avg_Cases_Total,Le.Crime_Score,Le.Crime_Score+1);
 SELF := Ri;
END;

final := SORT(ITERATE(ds,Calc(LEFT,RIGHT)),State);

OUTPUT(final,,'~pos::spr::Crime_scores',NAMED('Crime_Scores'),OVERWRITE);