/*  cleans variables by calling default script

--------
Verbatim
--------


---------
Changelog
---------

Date      Name        Reason
------------------------------------------------------------------
11-08-06  Disco       Start of header
------------------------------------------------------------------

*/


//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------


void main(){

    object oPC = GetPCSpeaker();

    DeleteLocalObject( oPC, "ds_target" );
}

