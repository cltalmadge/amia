//::///////////////////////////////////////////////
//:: FileName ck_is4sd
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 30/04/2005 19:40:55
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER, GetPCSpeaker()) >= 4)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
