IMPORT $;

Rec := RECORD
 STRING25 State;
 DECIMAL3_1 Avg_Unemp;
END;

DSA := DATASET('~pos::spr::unemp',Rec,FLAT);

New_Rec := RECORD
 DSA.State;
 DSA.Avg_Unemp;
 DECIMAL2 Unemp_Score := 0;
END;

Sort_Unemp := SORT(TABLE(DSA,New_Rec,State,Avg_Unemp),-Avg_Unemp);

Sort_Unemp Calc_Unemp(Sort_Unemp Le,Sort_Unemp Ri) := TRANSFORM
 SELF.Unemp_Score := IF(Le.Avg_Unemp = Ri.Avg_Unemp,Le.Unemp_Score,Le.Unemp_Score+1);
 SELF := Ri
END;

Unemp_Scr_Tab := ITERATE(Sort_Unemp,Calc_Unemp(LEFT,RIGHT));

Final := SORT(Unemp_Scr_Tab,State);

OUTPUT(Final,,'pos::spr::unemployment_score',NAMED('Unemployment_Scores'),OVERWRITE);