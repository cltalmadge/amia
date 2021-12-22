//::///////////////////////////////////////////////
//:: FileName ck_haseaglefreez
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/02/2006 17:14:26
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "ki_eagleclaw"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "ki_freezblood"))
		return FALSE;

	return TRUE;
}
