/*
languages_bonus

---------------------------------------------------------------------------------
Verbatim
---------------------------------------------------------------------------------
This script shows bonus languages

---------------------------------------------------------------------------------
Changelog
---------------------------------------------------------------------------------
Date            Name       Reason
------------------------------------------------
06-29-2006      disco      Start of header
------------------------------------------------
*/

//-------------------------------------------------------------------------------
//includes
//-------------------------------------------------------------------------------
#include "languages_lib"

//-------------------------------------------------------------------------------
//main
//-------------------------------------------------------------------------------
void main(){


    // Variables
    object oPC = GetLocalObject( OBJECT_SELF, "lan_target");

    ShowSelectableLanguages( oPC, GetRaceIndex( oPC ) );

}


