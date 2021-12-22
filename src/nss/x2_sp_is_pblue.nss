//::///////////////////////////////////////////////
//:: Name x2_sp_is_pblue
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Ioun Stone Power: Pale Blue
    Gives the user 1 hours worth of +2 Strength bonus.
    Cancels any other Ioun stone powers in effect
    on the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: Dec 13/02
//:://////////////////////////////////////////////
//:: PaladinOfSune: Added new hak visual
//:: Glim: Changed to permanent duration and Supernatural effect.

void main()
{
    //variables
    effect eVFX, eBonus, eLink, eEffect;

    //from any ioun stones (including self)
    eEffect = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if(GetEffectSpellId(eEffect) > 553 && GetEffectSpellId(eEffect) < 561
            || GetEffectSpellId(eEffect) == 918
            || GetEffectSpellId(eEffect) == 919 )
        {
            RemoveEffect(OBJECT_SELF, eEffect);
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }

    //Apply new ioun stone effect
    eVFX = EffectVisualEffect(690);
    eBonus = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
    eLink = EffectLinkEffects(eVFX, eBonus);
    eLink = SupernaturalEffect( eLink );
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);

}
