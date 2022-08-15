/*
  Job System Item Refresh Script - Converts the old, larger Job System PLCs into smaller counterparts

  - Lord-Jyssev
*/


void main()
{
    object oInContainer = GetFirstItemInInventory( OBJECT_SELF );
    object oPC          = GetLastClosedBy();
    object oRefreshedItem;
    string sItemResRef;
    string sName;
    string sMaterial;
    string sType;
    string sWeaponResRef;
    int nWeaponMaterial;
    int nArmorMaterial;
    int nStackSize;
    int nRefreshedItem;

    while (GetIsObjectValid( oInContainer ) == TRUE)
    {
        sItemResRef     = GetResRef(oInContainer);

        // Disallow equipable items that allow properties/mythal crafting and non-job items
        if(     GetSubString(sItemResRef, 0, 3) != "js_"
             || sItemResRef == "js_arch_adbt"
             || sItemResRef == "js_arch_irbt"
             || sItemResRef == "js_arch_sibt"
             || sItemResRef == "js_arch_stbt"
             || sItemResRef == "js_arch_adbu"
             || sItemResRef == "js_arch_irbu"
             || sItemResRef == "js_arch_sibu"
             || sItemResRef == "js_arch_stbu"
             || sItemResRef == "js_arch_adar"
             || sItemResRef == "js_arch_irar"
             || sItemResRef == "js_arch_siar"
             || sItemResRef == "js_arch_star"
             || sItemResRef == "js_arch_cbow"
             || sItemResRef == "js_arch_lbow"
             || sItemResRef == "js_arch_bow"
             || sItemResRef == "js_arch_sbow"
             || sItemResRef == "js_arca_bdbg"
             || sItemResRef == "js_arca_gmpo"
             || sItemResRef == "js_arca_mytu"
             || sItemResRef == "js_arca_scbx"
             || sItemResRef == "js_arca_trca"
             || sItemResRef == "js_arca_wdca"
             || GetSubString(sItemResRef, 0, 9) == "js_jew_am"
             || GetSubString(sItemResRef, 0, 9) == "js_jew_ri"
             || GetSubString(sItemResRef, 0, 9) == "js_bla_we"
             || GetSubString(sItemResRef, 0, 9) == "js_bla_ar"
             || GetSubString(sItemResRef, 0, 9) == "js_bla_sh"
             || sItemResRef == "js_bla_helm"
             || sItemResRef == "js_bla_grea"
             || sItemResRef == "js_bla_brac" )
        {
            sName = GetName(oInContainer);
            SendMessageToPC(oPC, "<c�  >" + sName + " cannot be refreshed.</c>");
        }
        else if( GetSubString(sItemResRef, 0, 3) == "js_")
        {
            //Grab all the necessary details, including name and associated variables
            sName              = GetName(oInContainer);
            sMaterial          = GetLocalString(oInContainer, "material");
            sType              = GetLocalString(oInContainer, "plc");
            sWeaponResRef      = GetLocalString(oInContainer, "weapon");
            nWeaponMaterial    = GetLocalInt(oInContainer, "material");
            nArmorMaterial     = GetLocalInt(oInContainer, "armormaterial");
            nStackSize         = GetNumStackedItems(oInContainer);
            nRefreshedItem     = GetLocalInt(oInContainer, "RefreshedItem");

            //Recreate the item
            oRefreshedItem = CreateItemOnObject(sItemResRef, OBJECT_SELF, nStackSize);

            SetName(oRefreshedItem, sName);

            //Check if variables aren't null and set them on the new item
            if(sMaterial != "")         { SetLocalString(oRefreshedItem, "material", sMaterial); }
            if(sType != "")             { SetLocalString(oRefreshedItem, "plc", sType); }
            if(sWeaponResRef != "")     { SetLocalString(oRefreshedItem, "weapon", sWeaponResRef); }
            if(nWeaponMaterial != 0)    { SetLocalInt(oRefreshedItem, "material", nWeaponMaterial); }
            if(nArmorMaterial != 0)     { SetLocalInt(oRefreshedItem, "armormaterial", nArmorMaterial); }
            if(nRefreshedItem != 0)     { SetLocalInt(oRefreshedItem, "RefreshedItem", 1); }

            //Delete the old item
            DestroyObject( oInContainer, 0.1 );
        }

        if(GetLocalInt(GetNextItemInInventory( OBJECT_SELF ), "RefreshedItem") != 1)
        {
            oInContainer = GetNextItemInInventory( OBJECT_SELF );
        }
        else
        {
            break;
        }
    }

}
