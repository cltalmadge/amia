/////////////////////////////////////////////////////////////////////////////////////////////////
//This script it to add the boar lycan feat to the player and set variables from a conversation//
//                                                                                             //
//created by Frozen-ass                                                                        //
//date: 28-06-2022                                                                             //
/////////////////////////////////////////////////////////////////////////////////////////////////

#include "inc_ds_records"
#include "nwnx_creature"


void main( )
{

    // Variables.
    object oPC                      = GetPCSpeaker( );
    object oTarget                  = GetObjectByTag("ds_pckey");

        {
    DelayCommand( 5.0, NWNX_Creature_AddFeat( oPC, 1252) );
    SetLocalInt(oTarget, "lycanapproved", 1);
    SetLocalInt(oPC, "Prereq_Lycan", 1);
                {

              // Track and Report modification entry for Security purposes.
              // Variables.
           string szPlayerName     = GetPCPlayerName( oPC );
           string szCharacterName  = GetName( oPC );

              // Notify the Player.
              SendMessageToPC( oPC, "You will be booted for boar lycan to be added to your feat list." );

              // Update the character.
              ExportSingleCharacter( oPC );
              DelayCommand( 10.0, BootPC( oPC, "Wereboar infection added" ));
                }
        }
}
