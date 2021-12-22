/*
tha_quest_ck3

---------------------------------------------------------------------------------
Verbatim
---------------------------------------------------------------------------------
This is a universal convo checker.

---------------------------------------------------------------------------------
Changelog
---------------------------------------------------------------------------------
Date            Name       Reason
------------------------------------------------
04-29-2006      disco      Start of header
06-21-2006      disco      Check if the Priest is still in convo with a PC
20071103        Disco      Now uses databased PCKEY functions
------------------------------------------------
*/

//-------------------------------------------------------------------------------
//includes
//-------------------------------------------------------------------------------
#include "nw_i0_tool"
#include "inc_ds_records"

//-------------------------------------------------------------------------------
//prototypes
//-------------------------------------------------------------------------------
int tha_check_trader( object oPC );


//-------------------------------------------------------------------------------
//starting conditional
//-------------------------------------------------------------------------------
int StartingConditional( ){

    //variables
    object oPC          = GetPCSpeaker();
    string sConvoNPCTag = GetTag( OBJECT_SELF );

    //sometimes an NPC reacts to SpeakString from another NPC
    if( !GetIsPC( oPC ) ){

        return( FALSE );
    }

    //Howness Temple, check for quest 1
    if ( sConvoNPCTag == "tha_highpriest" ){

        if ( GetPCKEYValue( oPC, "tha_quest1" ) > 0 ){

            return FALSE;
        }
     }
    //Thykkvi Monastery, check for quest 1
    else if ( GetTag( GetArea( OBJECT_SELF ) )  == "tha_i12" ){

        if ( GetPCKEYValue( oPC, "tha_quest1" ) != 1 ){

            return FALSE;
        }
    }
    //Ostman in the Thirsty Marauder
    else if ( sConvoNPCTag == "tha_ostman" ){

        if ( GetPCKEYValue( oPC, "tha_quest6" ) > 0 ){

            return TRUE;
        }
    }
    //Child in Forgotten Ruins
    else if ( sConvoNPCTag == "tha_child" ){

        if ( GetPCKEYValue( oPC, "tha_quest7" ) == 1 ){

            return FALSE;
        }
    }
    //Thirmir in Thordstein Buildings
    else if( sConvoNPCTag == "tha_thirmir" ){

        if ( GetPCKEYValue( oPC, "tha_quest7" ) != 2 ){

            return FALSE;
        }
    }
    else if ( sConvoNPCTag == "tha_recruiter" ){

        if ( tha_check_trader(oPC) == TRUE ){

            return FALSE;
        }
    }
    else if ( sConvoNPCTag == "tha_npc_to_howness1" || sConvoNPCTag == "tha_npc_to_cordor" ){

        if (!HasItem(oPC, "tha_trader_papers" ) ){

            return FALSE;
        }
    }
    //more ferry
    else if ( sConvoNPCTag == "tha_npc_to_uhm" || sConvoNPCTag == "tha_npc_to_thordstein" ){

        if (!HasItem(oPC, "tha_trader_papers" ) ){

            return FALSE;
        }
    }
    else if ( sConvoNPCTag == "tha_geezer" ){

        if ( tha_reputation( oPC, 0 ) < 4 ){

            return FALSE;
        }

        if (HasItem(oPC, "tha_map" ) ){

            return FALSE;
        }
    }
    //Howness Gate Street
    else if( sConvoNPCTag == "tha_hrolf" ){

        if ( GetPCKEYValue( oPC, "tha_quest5" ) > 0 ){

            return FALSE;
        }
    }
    else{

        return FALSE;
    }

    return TRUE;
}

//-------------------------------------------------------------------------------
// functions
//-------------------------------------------------------------------------------
int tha_check_trader(object oPC ){

    if ( HasItem( oPC, "tha_trader_papers" ) ){

        SpeakString("Are you nuts?! You already ARE a Trader! Give this poor sod a brandy, folks!");
        return FALSE;
    }
    if ( GetGold( oPC ) < 25000 ){

        SpeakString("I am sorry, but we do not accept beggars! Come back when you can pay for a glass of wine and a decent steak. Next?!");
        return FALSE;
    }
    if ( GetAlignmentGoodEvil( oPC ) == ALIGNMENT_EVIL && GetAlignmentLawChaos( oPC ) == ALIGNMENT_CHAOTIC ){

        SpeakString("Does this look like an asylum? Be off, maniac!");
        return FALSE;
    }
    if ( GetAlignmentGoodEvil( oPC ) == ALIGNMENT_GOOD && GetAlignmentLawChaos( oPC ) == ALIGNMENT_LAWFUL ){

        SpeakString("I heard enough of your pointless blathering!");
        return FALSE;
    }

    return TRUE;

    // Make sure the player has the required skills
    /*
    if ( GetSkillRank(SKILL_APPRAISE, oPC, TRUE) > 9 ){return TRUE;}
    if ( GetSkillRank(SKILL_CRAFT_ARMOR, oPC, TRUE) > 9 ){return TRUE;}
    if ( GetSkillRank(SKILL_CRAFT_TRAP, oPC, TRUE) > 9 ){return TRUE;}
    if ( GetSkillRank(SKILL_CRAFT_WEAPON, oPC, TRUE) > 9 ){return TRUE;}
    if ( GetSkillRank(SKILL_LORE, oPC, TRUE) > 9 ){return TRUE;}
    if ( GetSkillRank(SKILL_PERSUADE, oPC, TRUE) > 9 ){return TRUE;}
    SpeakString("You do not possess a single skill that has our interest. Get some education, friend.");
    return FALSE;
    */
}



