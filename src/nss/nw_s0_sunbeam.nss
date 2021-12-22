//::///////////////////////////////////////////////
//:: Sunbeam
//:: s_Sunbeam.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: All creatures in the beam are struck blind and suffer 4d6 points of damage. (A successful
//:: Reflex save negates the blindness and reduces the damage by half.) Creatures to whom sunlight
//:: is harmful or unnatural suffer double damage.
//::
//:: Undead creatures caught within the ray are dealt 1d6 points of damage per caster level
//:: (maximum 20d6), or half damage if a Reflex save is successful. In addition, the ray results in
//:: the total destruction of undead creatures specifically affected by sunlight if they fail their saves.
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: Feb 22, 2001
//:://////////////////////////////////////////////
//:: Last Modified By: Keith Soleski, On: March 21, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "inc_td_shifter"
void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eStrike = EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eDam;
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBlind, eDur);

    int nCasterLevel= GetNewCasterLevel(OBJECT_SELF);
    int nDamage;
    int nOrgDam;
    int nMax;
    float fDelay;
    int nDC = GetShifterDC( OBJECT_SELF, GetSpellSaveDC( ) );
    int nBlindLength = 3;
    int nCap = 20;
    int nBonusDice = 0;

    //determin bonus for spell foci
    if (GetHasFeat (FEAT_SPELL_FOCUS_EVOCATION, OBJECT_SELF))
    {
        nCap = 22;
        nBonusDice = 1;
    }
    if (GetHasFeat (FEAT_GREATER_SPELL_FOCUS_EVOCATION, OBJECT_SELF))
    {
        nCap = 24;
        nBonusDice = 2;
    }
    if (GetHasFeat (FEAT_EPIC_SPELL_FOCUS_EVOCATION, OBJECT_SELF))
    {
        nCap = 26;
        nBonusDice = 3;
    }
    //Limit caster level
    if (nCasterLevel > nCap)
    {
        nCasterLevel = nCap;
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        // Make a faction check
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay(1.0, 2.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));
            //Make an SR check
            if ( ! MyResistSpell(OBJECT_SELF, oTarget, 1.0))
            {
                //Check if the target is an undead
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    //Roll damage and save
                    nDamage = d6(nCasterLevel);
                    nMax = 6;
                }
                else
                {
                    //Roll damage and save
                    nDamage = d6(3 + nBonusDice);
                    nOrgDam = nDamage;
                    nMax = 6;
                    nCasterLevel = 3;
                    //Get the adjusted damage due to Reflex Save, Evasion or Improved Evasion
                }

                //Do metamagic checks
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nMax * nCasterLevel;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }

                //Check that a reflex save was made.
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 1.0) == 0)
                {
                    if( GetLocalInt( oTarget, "blind_immune" ) != 1 )
                    {
                        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength)));
                        if (GetHasFeat (FEAT_IMPROVED_EVASION, oTarget))
                        {
                            nDamage = nDamage/2;
                        }
                    }
                }
                else
                {
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_DIVINE);
                }

                //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                if(nDamage > 0)
                {
                    //Apply the damage effect and VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
            }
        }
        //Get the next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    }
}
