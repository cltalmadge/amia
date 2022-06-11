// Shadow Jump feat.
//
// Revision History
// Date       Name             Description
// ---------- ---------------- ---------------------------------------------
// 10/10/2011 PaladinOfSune    Initial release.
// 6/11/2022  The1Kobra        Update to handle cooldown logout bug.
//

#include "amia_include"

void main( ) {

    // Declare variables
    object oPC = OBJECT_SELF;
    object oArea = GetArea( oPC );
    object oTarget=GetSpellTargetObject();
    int nDuration = 264 - (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC)*12);
    float fDuration = IntToFloat(nDuration);

    location lTarget = GetSpellTargetLocation();

    // Backup check for logout shinnanegans.
    if (GetLocalInt(oPC, "ShadowJumpExpiration") != 0) {
        if (GetRunTimeInSeconds() > GetLocalInt(oPC,"ShadowJumpExpiration")) {
            DeleteLocalInt(oPC,"ShadowJumpCooldown");
            DeleteLocalInt(oPC,"ShadowJumpExpiration");
        }
    }

    // Check if they can Shadow Jump here
    if( GetLocalInt( oArea, "CS_NO_SHADOWJUMP" ) == 1 ) {
        FloatingTextStringOnCreature( "- You are unable to Shadow Jump in this area! -", oPC, FALSE );
        return;
    }

    if(GetLocalInt(oPC,"ShadowJumpCooldown") == 0)
    {
    // Apply visual candy
    ApplyEffectAtLocation( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_DEATH_WARD ), GetLocation( oPC ) );
    ApplyEffectAtLocation( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_DEATH_WARD ), lTarget );

    // Jump PC to location and clear all actions afterward to prevent any weirdness
    AssignCommand( oPC, ActionJumpToLocation( lTarget ) );
    DelayCommand( 0.8, AssignCommand( oPC, ClearAllActions( ) ) );
    SetLocalInt(oPC,"ShadowJumpCooldown",1);
    SetLocalInt(oPC,"ShadowJumpExpiration",GetRunTimeInSeconds()+nDuration);
    DelayCommand(fDuration, DeleteLocalInt(oPC,"ShadowJumpCooldown"));
    FloatingTextStringOnCreature( "Shadow Jump Cooldown: " + FloatToString(fDuration,3,0), oPC, FALSE );
    } else {
     FloatingTextStringOnCreature( "- You are unable to use Shadow Jump while on cool down! -", oPC, FALSE );
    }

}