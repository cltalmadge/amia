//-----------------------------------------------------------------------------
// header
//-----------------------------------------------------------------------------
//script:  ds_trans_actions
//group:   player death
//used as: action script
//date:    march 8 2008
//author:  disco


//-------------------------------------------------------------------------------
// includes
//-------------------------------------------------------------------------------
#include "inc_ds_died"

//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------
void main(){

    object oPC  = OBJECT_SELF;

    SetPvpMode( oPC );
}

