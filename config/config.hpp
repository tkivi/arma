//###########################################################################################
// Configuration options. Add comment marks // to disable => can be edited in EDEN editor. ##
//###########################################################################################

// Choose respawn type. Remember to add possible respawn markers in EDEN or spawn point added by Zeus in game.
// https://community.bistudio.com/wiki/Arma_3:_Respawn#Respawn_Types
//	ID	Text version	
//	0	"NONE"		No respawn.
//	1	"BIRD"		Respawn as a seagull.
//	2	"INSTANT"	Respawn just where you died.
//	3	"BASE"		Respawn in base.
//					A respawn marker or spawn point added by Zeus is needed. If no marker or spawn point is defined, respawn behaviour will be the same as "INSTANT".
//					Marker role names:
//						Unit respawn: respawn_SIDE
//						Vehicle respawn: respawn_vehicle_SIDE
//					Side can be one of west, east, guerrila, civilian, e.g respawn_west.
//					Any suffix (eg: respawn_westABC, respawn_west_1, etc) will allow multiple random respawn points.
//	4	"GROUP"		Respawn in your group. If there is no remaining AI, you will become a seagull.
//	5	"SIDE"		Respawn into an AI unit on your side (if there's no AI left, you'll become a seagull).
//					With this respawn type, team switch is also available to any AI controlled playable units.
respawn = 3;

// Lets players select from available respawn positions defined either by respawn markers or by Zeus.
// https://community.bistudio.com/wiki/Arma_3:_Respawn#Respawn_Templates
// Use "ace_spectator" for ACE spectator.
// https://ace3mod.com/wiki/framework/spectator-framework.html
respawnTemplates[] = {"MenuPosition"};

// Set respawn delay in seconds.
respawnDelay = 15;