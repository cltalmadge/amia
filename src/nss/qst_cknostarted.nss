/*! \file qst_cknostarted.nss
 * \brief Scripted quests check not started.
 *
 * Conversation conditional to check if a PC has not yet started an NPCs
 * quest.
 * \verbatim
 * Revision History
 * Date       Name             Description
 * ---------- ---------------- ---------------------------------------------
 * 07/04/2004 jpavelch         Initial release.
 * 12/14/2004 jpavelch         Using QST_* constants.
 * \endverbatim
 */

#include "quests_inc"
#include "logger"

//! Script entry point.
/*!
 * Retrieves the quest identifier from the NPC and calls into the
 * quest framework.  Writes a message to the error log if a quest
 * identifier could not be found.
 * \par Local Variables
 * \li \a QuestTag Used on the NPC to store the quest identifier.
 * \return \a TRUE If the NPCs quest has not been started, otherwise
 *         \a FALSE.
 * \return \a FALSE If the quest tag could not be found on the NPC.
 */
int StartingConditional( )
{
    object oNPC = OBJECT_SELF;
    string sQuestTag = GetLocalString( oNPC, QST_TAG_VAR );
    if ( sQuestTag == "" ) {
        LogError( "qst_cknostarted", "## Scripted Quests: Could not find quest "
                                    + " for npc: " + GetName(oNPC) );
        return FALSE;
    }

    int nStatus = QST_GetStatus( GetPCSpeaker(), sQuestTag );
    return ( nStatus == QST_NOTSTARTED );
}
