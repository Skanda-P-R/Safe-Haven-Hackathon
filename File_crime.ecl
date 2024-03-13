EXPORT File_crime := MODULE
EXPORT Layout := RECORD
    STRING State;
    UNSIGNED Year;
    STRING Group_Name;
    STRING Sub_Group_Name;
    UNSIGNED K_A_Cases_Reported;
    UNSIGNED K_A_Female_10_15_Years;
    UNSIGNED K_A_Female_15_18_Years;
    UNSIGNED K_A_Female_18_30_Years;
    UNSIGNED K_A_Female_30_50_Years;
    UNSIGNED K_A_Female_Above_50_Years;
    UNSIGNED K_A_Female_Total;
    UNSIGNED K_A_Female_Upto_10_Years;
    UNSIGNED K_A_Grand_Total;
    UNSIGNED K_A_Male_10_15_Years;
    UNSIGNED K_A_Male_15_18_Years;
    UNSIGNED K_A_Male_18_30_Years;
    UNSIGNED K_A_Male_30_50_Years;
    UNSIGNED K_A_Male_Above_50_Years;
    UNSIGNED K_A_Male_Total;
    UNSIGNED K_A_Male_Upto_10_Years;
END;

EXPORT File := DATASET('~pos::spr::crime',Layout,CSV)(Year<>0);

END;