#include "inc_recall_stne"


void CheckHenchmen(object oPC, object oTarget); // Check to see if they are restricted movement wise

void main()
{
    object player = GetLastUsedBy();
    string waypointTag = GetLocalString(OBJECT_SELF, LVAR_RECALL_WP);
    object portalDestination = GetObjectByTag(waypointTag);

    CheckHenchmen(player,portalDestination);

    DelayCommand( 1.0, AssignCommand( player, ClearAllActions() ) );
    DelayCommand( 1.1, AssignCommand( player, JumpToObject( portalDestination, 0 ) ) );
}

void CheckHenchmen(object oPC, object oTarget)
{
   int i=1;
   object oHench = GetHenchman(oPC,i);
   int nMax = GetMaxHenchmen();

   while(GetIsObjectValid(oHench))
   {

    if((GetLocalInt(oHench,"LimitMovement")==1) && (GetArea(oPC)!=GetArea(oTarget)))  // By default it will allow in area movement
    {
      RemoveHenchman(oPC,oHench);
    }
    i++;
    oHench = GetHenchman(oPC,i);
   }
}
