//::///////////////////////////////////////////////
//:: FileName ck_hasass3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 29/10/2005 16:10:38
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "asninv"))
		return FALSE;

	return TRUE;
}
