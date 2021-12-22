//-----------------------------------------------------------------------------
// header
//-----------------------------------------------------------------------------
//script: i_ds_rental_item
//group: rentable housing
//used as: item activation script
//date: 2009-09-04
//author: disco

//-------------------------------------------------------------------------------
// includes
//-------------------------------------------------------------------------------
#include "x2_inc_switches"
#include "inc_ds_actions"
#include "inc_ds_rental"

//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------
void main(){

    //event variables
    int nEvent  = GetUserDefinedItemEventNumber();
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent){

        case X2_ITEM_EVENT_ACTIVATE:

            // item activate variables
            object oPC       = GetItemActivator();
            object oItem     = GetItemActivated();
            object oTarget   = GetItemActivatedTarget();
            location lTarget = GetItemActivatedTargetLocation();
            string sPCKEY    = GetName( GetPCKEY( oPC ) );

            if ( GetLocalString( GetArea( oPC ), RNT_OWNER ) != sPCKEY ){

                SendMessageToPC( oPC, "You can't use that item outside your house." );
                return;
            }

            clean_vars( oPC, 4 );

            SetLocalString( oPC, "ds_action", RNT_LAYOUT_TAG );
            SetLocalLocation( oPC, "ds_target", lTarget );
            SetLocalObject( oPC, "ds_target", oItem );

            if ( GetIsPC( oTarget ) ){

                SetLocalInt( oPC, "ds_check_1", 1 );
                SetLocalObject( oPC, "ds_target", oTarget );
            }
            else{

                int nCharges = GetItemCharges( oItem );

                if ( nCharges == 10 ){

                    SetLocalInt( oPC, "ds_check_11", 1 );
                }
                else if ( nCharges == 20 ){

                    SetLocalInt( oPC, "ds_check_12", 1 );
                }
                else if ( nCharges == 30 ){

                    SetLocalInt( oPC, "ds_check_13", 1 );
                }
            }

            AssignCommand( oPC, ActionStartConversation( oPC, RNT_LAYOUT_TAG, TRUE, FALSE ) );


        break;
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}






