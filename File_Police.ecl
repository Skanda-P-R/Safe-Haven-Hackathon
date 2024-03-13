EXPORT File_Police := MODULE
EXPORT Layout := RECORD
    STRING State;
    UNSIGNED Year;
    STRING Group_Name;
    STRING Sub_Group_Name;
    UNSIGNED PH_Houses_Provided_by_Department;
    UNSIGNED PH_Houses_provided_on_LeaseRentGPRA;
    UNSIGNED PH_Sanctioned_Strength;
    STRING field8;
    STRING field9;
END;

EXPORT File := DATASET('~pos::spr::policestations',Layout,CSV)(Year<>0);
END;