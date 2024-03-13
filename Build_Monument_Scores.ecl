IMPORT $;

rec :=RECORD
STRING State;
UNSIGNED numbers_of_monuments;
UNSIGNED Monuments_Score := 0;
END;

ds := SORT(DATASET('~pos::spr::Analyse_Monumetents',rec,THOR),-numbers_of_monuments);

rec Calc(rec Le,rec Ri) := TRANSFORM
 SELF.Monuments_Score := IF(Le.numbers_of_monuments = Ri.numbers_of_monuments,Le.Monuments_Score,Le.Monuments_Score+1);
 SELF := Ri;
END;

final := SORT(ITERATE(ds,Calc(LEFT,RIGHT)),State);

OUTPUT(final,,'~pos::spr::Monuments_scores',NAMED('Monuments_Scores'),OVERWRITE);