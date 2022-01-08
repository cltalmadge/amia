//-----------------------------------------------------------------------------
// header
//-----------------------------------------------------------------------------
//script:  ele_raid_damage


//-------------------------------------------------------------------------------
// includes
//-------------------------------------------------------------------------------
#include "ds_ai2_include"

void Spawn(string sCreature, location lLocation);
//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------
void main(){

    object oCritter     = OBJECT_SELF;
    object oDamager     = GetLastDamager();
    object oTarget      = GetLocalObject( oCritter, L_CURRENTTARGET );
    string sArchetype   = GetLocalString( oCritter, L_ARCHETYPE );
    int nReaction       = GetReaction( oCritter, oDamager );


    if ( nReaction == 2 ){

        if ( GetDistanceBetween( oCritter, oDamager ) < 5.0 ){

            ClearAllActions();
            ActionMoveAwayFromObject( oDamager, TRUE, 10.0 );
            SetLocalObject( oCritter, L_CURRENTTARGET, oDamager );
        }
    }
    else if ( nReaction == 1 ){

        if ( oTarget != oDamager ){

            if ( GetObjectSeen( oDamager, oCritter ) && ( d100() - 20 ) < 25 ){

                SetLocalObject( oCritter, L_CURRENTTARGET, oDamager );
            }
        }
    }

    //Check for %health based triggers
    int nHP = GetPercentageHPLoss( oCritter );

    string sResRef = GetResRef(oCritter);
    int nRandom = Random(25)+1;

    // If the damage dealer has the endamage variable set to 1 it means its environmental damage and to be ignored
    if(GetLocalInt(oDamager, "endamage") == 1)
    {
      return;
    }

    if(nRandom == 10)
    {
     if(sResRef == "elemental_raid_1")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }
     else if(sResRef == "elemental_raid_2")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }
     else if(sResRef == "elemental_raid_3")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }
     else if(sResRef == "elemental_raid_4")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }
     else if(sResRef == "elemental_raid_5")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }
     else if(sResRef == "elemental_raid_6")
     {
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepLeftLocation(oCritter)));
       DelayCommand(1.0,Spawn("elemental_raid_7", GetStepRightLocation(oCritter)));
       SpeakString("*Fragments chip off the elemental and begin to fight you as well*");
     }

    }

}

void Spawn(string sCreature, location lLocation)
{
  effect eVisE = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
  object oCritterS1 = CreateObject(OBJECT_TYPE_CREATURE,sCreature,lLocation);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVisE,lLocation);
}
