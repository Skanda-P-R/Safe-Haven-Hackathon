EXPORT File_Unemployment := MODULE
 EXPORT Layout := RECORD
    DECIMAL2 Sl_No;
    STRING17 State;
    DECIMAL3_1 Unemployment_Rate_in_2011_12;
    DECIMAL3_1 Unemployment_Rate_in_2012_13;
    DECIMAL3_1 Unemployment_Rate_in_2013_14;
    DECIMAL3_1 Unemployment_Rate_in_2015_16;
    DECIMAL3_1 Unemployment_Rate_in_2017_18;
    DECIMAL3_1 Unemployment_Rate_in_2018_19;
    DECIMAL3_1 Unemployment_Rate_in_2019_20;
 END;
 EXPORT File := DATASET('~pos::spr::unemployment',Layout,CSV);
END;