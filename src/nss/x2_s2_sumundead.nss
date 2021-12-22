//-----------------------------------------------------------------------------
// header
//-----------------------------------------------------------------------------
//script:  x2_s2_sumundead
//group:   summons
//used as: special ability script (doesn't trigger spellhook)
//date:    jan 20 2008
//author:  disco

//-------------------------------------------------------------------------------
// includes
//-------------------------------------------------------------------------------
#include "inc_ds_summons"

//-------------------------------------------------------------------------------
// main
//-------------------------------------------------------------------------------
void main(){

    //Trigger spellhook
    if (!X2PreSpellCastCode())
        return;

    sum_SummonUndead( OBJECT_SELF, 1, 4, 2 );
}
