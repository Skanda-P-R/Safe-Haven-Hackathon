EXPORT File_Monuments := MODULE
EXPORT Layout := RECORD
    UNSIGNED Sl_No;
    STRING State;
    UNSIGNED Numbers_of_Monuments;
END;

EXPORT File := DATASET('~pos::spr::monuments_skanda.csv',Layout,CSV)(State<>'State/UT');
END;