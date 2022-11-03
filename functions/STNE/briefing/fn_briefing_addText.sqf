/*
 * Add text to briefing.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_briefing_addText;
 *
 */

// Header
player createDiarySubject
[
	"DCSARMA_briefing",
	"DCSARMA"
];

// Convert respawn number to string
private _RespawnType = "Unknown";
switch (getMissionConfigValue ["respawn", 99]) do {
	case 0: {_RespawnType = "NONE";};
	case 1: {_RespawnType = "BIRD";};
	case 2: {_RespawnType = "INSTANT";};
	case 3: {_RespawnType = "BASE";};
	case 4: {_RespawnType = "GROUP";};
	case 5: {_RespawnType = "SIDE";};
	default {_RespawnType = "Unknown";};
};

// Lines
private _Lines = [
	["Server:", ""] call STNE_fnc_briefing_getLine,
	["    - Name: ", serverName] call STNE_fnc_briefing_getLine,
	["    - Map: ", getText (configfile >> "CfgWorlds" >> worldName >> "description")] call STNE_fnc_briefing_getLine,
	["    - Mission: ", briefingName] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Respawn:", ""] call STNE_fnc_briefing_getLine,
	["    - Type: ", _RespawnType] call STNE_fnc_briefing_getLine,
	["    - Templates: ", getMissionConfigValue ["respawnTemplates", "Unknown"]] call STNE_fnc_briefing_getLine,
	["    - Delay: ", getMissionConfigValue ["respawnDelay", "Unknown"]] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Selectable loadouts:", ""] call STNE_fnc_briefing_getLine,
	["    - Loadouts: ", count ((missionNamespace getVariable ["STNE_loadout_Arsenal", [[],[]]]) select 0)] call STNE_fnc_briefing_getLine,
	["    - Keep loadout on respawn: ", missionNamespace getVariable ["STNE_loadout_Respawn", false]] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Spawnable server groups:", ""] call STNE_fnc_briefing_getLine,
	["    - Custom groups: ", count (missionNamespace getVariable ["STNE_server_CustomGroups", []])] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Vehicle in Vehicle logistic:", ""] call STNE_fnc_briefing_getLine,
	["    - Extended version: ", missionNamespace getVariable ["STNE_logistic_ViV", false]] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Sandbox:", ""] call STNE_fnc_briefing_getLine,
	["    - Spawn arsenal equipment: ", missionNamespace getVariable ["STNE_sandbox_Arsenal", false]] call STNE_fnc_briefing_getLine,
	["    - Assign all players as Zeus: ", missionNamespace getVariable ["STNE_sandbox_Zeus", false]] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["UnitPlay:", ""] call STNE_fnc_briefing_getLine,
	["    - Captured tracks: ", count (missionNamespace getVariable ["STNE_unitplay_Data", []])] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Fortify:", ""] call STNE_fnc_briefing_getLine,
	["    - ACE Fortify objects: ", count (missionNamespace getVariable ["STNE_ace_Fortify", []])] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Database:", ""] call STNE_fnc_briefing_getLine,
	["    - Enabled: ", missionNamespace getVariable ["STNE_database_Enabled", false] && "INIDBI2" in STNE_server_Mods] call STNE_fnc_briefing_getLine,
	["    - Name: ", missionNamespace getVariable ["STNE_database_Name", ""]] call STNE_fnc_briefing_getLine,
	["    - Use player vehicleVarName instead UID: ", missionNamespace getVariable ["STNE_database_PlayerVarName", false]] call STNE_fnc_briefing_getLine,
	["    - Save player loadout: ", missionNamespace getVariable ["STNE_database_PlayerLoadout", false]] call STNE_fnc_briefing_getLine,
	["    - Save player location: ", missionNamespace getVariable ["STNE_database_PlayerLocation", false]] call STNE_fnc_briefing_getLine,
	["    - Save player traits: ", missionNamespace getVariable ["STNE_database_PlayerTraits", false]] call STNE_fnc_briefing_getLine,
	["    - Save vehicle status: ", missionNamespace getVariable ["STNE_database_VehicleStatus", false]] call STNE_fnc_briefing_getLine,
	["    - Save player on disconnect: ", missionNamespace getVariable ["STNE_database_SaveAtDisconnect", false]] call STNE_fnc_briefing_getLine,
	["    - Save all data when mission ends: ", missionNamespace getVariable ["STNE_database_SaveAtEnd", false]] call STNE_fnc_briefing_getLine,
	["    - Track building status on map: ", missionNamespace getVariable ["STNE_database_TrackBuilding", false]] call STNE_fnc_briefing_getLine,
	["    - Track ACE Fortify objects: ", missionNamespace getVariable ["STNE_database_TrackFortify", false]] call STNE_fnc_briefing_getLine,
	["    - Save all placed mines: ", missionNamespace getVariable ["STNE_database_Mines", false]] call STNE_fnc_briefing_getLine,
	["    - Save all player created global map markers: ", missionNamespace getVariable ["STNE_database_Markers", false]] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Supported DLC/Mods loaded:", ""] call STNE_fnc_briefing_getLine,
	["    DLC:", ""] call STNE_fnc_briefing_getLine,
	["        - S.O.G. Prairie Fire: ", "SOG" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - Western Sahara: ", "WS" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["    Recommended mods:", ""] call STNE_fnc_briefing_getLine,
	["        - CBA: ", "CBA" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - ACE: ", "ACE" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - Zeus Enchanced: ", "ZEN" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["    Optional mods:", ""] call STNE_fnc_briefing_getLine,
	["        - INIDBI2: ", "INIDBI2" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - Immersion Cigs: ", "IMMERSIONCIGS" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - MRH Satellite: ", "MRHSATELLITE" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - cTab: ", "CTAB" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["        - BlindZeus: ", "BLINDZEUS" in (missionNamespace getVariable ["STNE_server_Mods", []])] call STNE_fnc_briefing_getLine,
	["", ""] call STNE_fnc_briefing_getLine,
	["Mission Framework by Stone:", ""] call STNE_fnc_briefing_getLine,
	["    - Version: ", "221102"] call STNE_fnc_briefing_getLine
];

// Format message
private _Message = "";
for "_i" from 1 to (count _Lines) do {
	_Message = _Message + "%" + str(_i);
};
private _MessageFormat = [_Message];
_MessageFormat append _Lines;

// Record
player createDiaryRecord
[
	"DCSARMA_briefing",
	[
		"Mission Framework",
		format _MessageFormat
	]
];