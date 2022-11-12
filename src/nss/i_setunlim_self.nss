/////////////////////////////////////////////////////////////////////////////////////////////////
//This script it to replace a x/day unique self to unlimited/day unique self (mainly intended  //
//for use on widgets that are now replaced with unlimited usage, without need to remake them   //
//created by Frozen-ass                                                                        //
//date: 01-11-2022                                                                             //
/////////////////////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_itemprop"


void main(){

    int nEvent  = GetUserDefinedItemEventNumber();
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent){

        case X2_ITEM_EVENT_ACTIVATE:


            object oTarget   = GetItemActivatedTarget();
            object oPC       = GetItemActivator(); {

                 itemproperty iNew = ItemPropertyCastSpell( 335, IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE );
                 IPSafeAddItemProperty( oTarget, iNew, 0.0f, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE );

                 AssignCommand( oPC, SpeakString( "<c � >Changed: ~</c>" +GetName ( oTarget ) + "<c � >~ to unlimited uses self</c>" ) );
            }

        break;
    }

}