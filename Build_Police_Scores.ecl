IMPORT $;

rec :=RECORD
STRING State;
UNSIGNED avg_police_houses_total;
UNSIGNED Police_Score := 0;
END;

ds := SORT(DATASET('~pos::spr::Analyse_Police',rec,THOR),-avg_police_houses_total);

rec Calc(rec Le,rec Ri) := TRANSFORM
 SELF.Police_Score := IF(Le.avg_police_houses_total = Ri.avg_police_houses_total,Le.Police_Score,Le.Police_Score+1);
 SELF := Ri;
END;

final := SORT(ITERATE(ds,Calc(LEFT,RIGHT)),State);

OUTPUT(final,,'~pos::spr::Police_scores',NAMED('Police_Scores'),OVERWRITE);