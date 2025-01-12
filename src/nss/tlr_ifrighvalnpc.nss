//::///////////////////////////////////////////////
//:: Tailoring - If Right Hand Item is Valid on NPC
//:: tlr_ifrighvalnpc.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in the NPC's right hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: February 20, 2006
//:://////////////////////////////////////////////
//void main (){}
int StartingConditional()
{
    /*if(GetLocalInt(OBJECT_SELF, "Weapon_Buy") == 0
       && GetLocalInt(OBJECT_SELF, "Weapon_Copy") == 0)
       return FALSE;*/

    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF)))
        return TRUE;
    else
        return FALSE;
}
