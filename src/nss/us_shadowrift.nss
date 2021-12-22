/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.3

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

AssignCommand(oPC, ClearAllActions());

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("shadowtodespair");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}

