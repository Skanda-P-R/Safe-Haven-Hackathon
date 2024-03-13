EXPORT File_Hospitals := MODULE
EXPORT Layout := RECORD
    UNSIGNED ID;
    STRING Hospital;
    STRING State;
    STRING City;
    STRING LocalAddress;
    UNSIGNED Pincode;
END;

EXPORT File := DATASET('~pos::spr::hospitals',Layout,CSV)(Hospital<>'Hospital');
END;