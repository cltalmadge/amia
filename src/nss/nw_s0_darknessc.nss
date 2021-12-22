// nw_s0_darknessc - Darkness (Ultravision Expiration/Removal)
//
// Rundown: (fired when an Ultravision spell expires or is removed)
// Step 1 - Checks if the PC is currently inside a Darkness AoE
// Step 2 - Checks for Darkness Immunity on creature skin
// Step 3 - Removes existing Darkness effects individually (has to be seperate)
// Step 4 - Checks for Ultravision Effect on target, applies only invisibility
// Step 5 - Applies new Darkness effects individually (has to be seperate)
// Step 6 - Starts tracking in case of multiple Darkness AoEs overlapping
//
// Revision History
// Date       Name                Description
// ---------- ------------------  --------------------------------------------
// 2013/05/15 Glim                Initial release

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "amia_include"
#include "nwnx_effects"

void main(){

    // vars
    object oTarget = OBJECT_SELF;

    //Check to see if the target is inside a Darkness effect, otherwise abort
    if( GetLocalInt( oTarget, "Darkness" ) == 0 )
    {
        return;
    }

    //Check for Darkness Immunity and end if found
    itemproperty ipImmune = ItemPropertySpellImmunitySpecific( IP_CONST_IMMUNITYSPELL_DARKNESS );
    object oHide = GetItemInSlot( INVENTORY_SLOT_CARMOUR, oTarget );
    if( IPGetItemHasProperty( oHide, ipImmune, DURATION_TYPE_PERMANENT, FALSE ) == TRUE )
    {
        return;
    }

    string szRace=GetSubRace(oTarget);

    effect eDark = EffectDarkness();
    effect eUV = EffectUltravision();
    effect eInvis = EffectInvisibility( INVISIBILITY_TYPE_DARKNESS );
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eDark, eDur);

    //April 2013: If already affected, remove the old effect before applying new one
    effect eAOE = GetFirstEffect(oTarget);

    while (GetIsEffectValid(eAOE))
    {
        //Removes the Darkness (blindness) portion of the effect
        if( GetEffectType( eAOE ) == EFFECT_TYPE_DARKNESS )
        {
            RemoveEffect(oTarget, eAOE);
        }
        //Removes the fake blindness
        else if( GetEffectType( eAOE ) == EFFECT_TYPE_BLINDNESS && GetEffectDurationType( eAOE ) == DURATION_TYPE_PERMANENT )
        {
            RemoveEffect(oTarget, eAOE);
        }
        //Get next effect on the target
        eAOE = GetNextEffect(oTarget);
    }
    /*  True Races vulnerability handling    */
    ApplyAreaAndRaceEffects( oTarget, 0, 2 );

    //Quick hack to apply UV effect itself for 1.0 sec
    ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eUV, oTarget, 0.5 );

    //Continue applying new effect
    if(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetEffectSpellId(eLink)));
        }
        else
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetEffectSpellId(eLink), FALSE));
        }
        // Creatures immune to the darkness spell are not affected.
        if ( ResistSpell(OBJECT_SELF,oTarget) != 2 || GetChallengeRating( oTarget ) < 42.0 )
        {
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, eInvis, oTarget );
            DelayCommand( 1.0, ApplyEffectToObject( DURATION_TYPE_PERMANENT, eLink, oTarget ) );
        }
        /*  True Races vulnerability handling    */
        ApplyAreaAndRaceEffects( oTarget, 0, 1 );
    }
}
