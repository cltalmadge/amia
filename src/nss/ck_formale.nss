//::///////////////////////////////////////////////
//:: FileName ck_formale
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/18/2003 6:17:29 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Add the gender restrictions
	if(GetGender(GetPCSpeaker()) != GENDER_MALE)
		return FALSE;

	return TRUE;
}
