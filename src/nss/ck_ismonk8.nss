//::///////////////////////////////////////////////
//:: FileName ck_ismonk8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/02/2006 17:19:23
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_MONK, GetPCSpeaker()) >= 8)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
