//Kamina 28/07/18
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "polydragcopp"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "polysdragcopp"))
        return FALSE;

    return TRUE;
}
