//::///////////////////////////////////////////////
//:: FileName c_callofkoloth
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/17/2005 4:33:03 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if( !HasItem(GetPCSpeaker(), "callofkoloth") )
        return FALSE;

    return TRUE;
}
