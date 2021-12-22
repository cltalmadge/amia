// Conversation conditional to check if PC is at least level 15.
//
// Revision History
// Date       Name             Description
// ---------- ---------------- ---------------------------------------------
// 09/11/2004 Artos            Initial release.
//

int StartingConditional( )
{
    return ( GetHitDice(GetPCSpeaker()) >= 15 );
}
