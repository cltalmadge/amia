//::///////////////////////////////////////////////
//:: FileName midrosestore_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7
//:://////////////////////////////////////////////
void main()
{

	// Either open the store with that tag or let the user know that no store exists.
	object oStore = GetNearestObjectByTag("MidRoseStore");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		OpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
