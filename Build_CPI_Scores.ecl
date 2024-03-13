IMPORT $;

CPI_DS :=$.File_CPI.File;

New_Rec := RECORD
 CPI_DS.State;
 CPI_DS.Average_CPI_2011_2020;
 DECIMAL2 CPI_Score := 0;
END;

Tab := TABLE(CPI_DS,New_Rec);

Sort_Tab := SORT(Tab,-Average_CPI_2011_2020);

//OUTPUT(Sort_Tab);

New_Rec Calc(Sort_Tab Le,Sort_Tab Ri) := TRANSFORM
 SELF.CPI_Score := IF(Le.Average_CPI_2011_2020 = Ri.Average_CPI_2011_2020,Le.CPI_Score,Le.CPI_Score+1);
 SELF := Ri;
END;

CPI_Ite := ITERATE(Sort_Tab,Calc(LEFT,RIGHT));

Final := SORT(CPI_Ite,State);

OUTPUT(Final,,'pos::spr::cpi_scores',NAMED('CPI_Scores'),OVERWRITE);