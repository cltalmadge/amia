//-----------------------------------------------------------------------------
// header
//-----------------------------------------------------------------------------
//script:  glm_orbofsunhrtb
//group:   custom items
//used as: OnHeartbeat Aura script for the Orb of the Sun
//date:    12/20/12
//author:  Glim

//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------

void main()
{
    object oItem = GetAreaOfEffectCreator( OBJECT_SELF );
    object oPC = GetItemPossessor( oItem );
    location lPC = GetLocation( oPC );

    //Set up Magic Circle of Protection effect
    effect eAC = EffectACIncrease( 2, AC_DEFLECTION_BONUS, AC_VS_DAMAGE_TYPE_ALL );
           eAC = VersusAlignmentEffect( eAC, ALIGNMENT_ALL, ALIGNMENT_EVIL );
           eAC = SupernaturalEffect( eAC );
    effect eSaves = EffectSavingThrowIncrease( SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL );
           eSaves = VersusAlignmentEffect( eSaves, ALIGNMENT_ALL, ALIGNMENT_EVIL );
           eSaves = SupernaturalEffect( eSaves );
    effect eMind = EffectImmunity( IMMUNITY_TYPE_MIND_SPELLS );
           eMind = VersusAlignmentEffect( eMind, ALIGNMENT_ALL, ALIGNMENT_EVIL );
           eMind = SupernaturalEffect( eMind );
    effect eVis1 = EffectVisualEffect( VFX_DUR_PROTECTION_GOOD_MINOR );
           eVis1 = SupernaturalEffect( eVis1 );
    //Set up Death Ward effect
    effect eWard = EffectImmunity( IMMUNITY_TYPE_DEATH );
           eWard = SupernaturalEffect( eWard );
    //Set up Turn Undead bonus (done as a decrease to Turn Resist on undead in AoE)
    effect eTurn = EffectTurnResistanceDecrease( 4 );
           eTurn = SupernaturalEffect( eTurn );
    effect eVis2 = EffectVisualEffect( VFX_DUR_PROTECTION_EVIL_MINOR );
           eVis2 = SupernaturalEffect( eVis2 );

    //Cycle targets
    object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, 12.2, lPC, FALSE, OBJECT_TYPE_CREATURE );

    while( GetIsObjectValid( oTarget ) )
    {
        //Undead (friendly or not) get reduced turn resistance
        if( GetRacialType( oTarget ) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly( oPC, oTarget ) )
        {
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eTurn, oTarget, 7.0 );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eVis2, oTarget, 7.0 );
            SignalEvent( oTarget, EventSpellCastAt( oPC, SPELL_BESTOW_CURSE, TRUE ) );
        }
        //Friendly folk get the protection buffs
        else if( !GetIsReactionTypeHostile( oPC, oTarget ) && !GetIsReactionTypeHostile( oTarget, oPC ) )
        {
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eAC, oTarget, 7.0 );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eSaves, oTarget, 7.0 );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eMind, oTarget, 7.0 );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eWard, oTarget, 7.0 );
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eVis1, oTarget, 7.0 );
        }
        oTarget = GetNextObjectInShape( SHAPE_SPHERE, 12.2, lPC, FALSE, OBJECT_TYPE_CREATURE );
    }
}
