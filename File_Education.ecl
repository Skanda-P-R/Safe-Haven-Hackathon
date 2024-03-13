EXPORT File_Education := MODULE
 EXPORT Layout := RECORD
    STRING25 State;
    STRING7 Year;
    DECIMAL5_2 Primary_Boys;
    DECIMAL5_2 Primary_Girls;
    DECIMAL5_2 Upper_Primary_Boys;
    DECIMAL5_2 Upper_Primary_Girls;
    DECIMAL5_2 Secondary_Boys;
    DECIMAL5_2 Secondary_Girls;
    DECIMAL5_2 Higher_Secondary_Boys;
    DECIMAL5_2 Higher_Secondary_Girls;
 END;
 EXPORT File := DATASET('~pos::spr::education',Layout,CSV);
END;