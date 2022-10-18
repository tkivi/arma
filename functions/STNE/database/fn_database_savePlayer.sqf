/*
 * Save player to database.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Disconnect UID <STRING>
 * 2: Player name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_savePlayer;
 *
 */

// Params
private _Player = param [0, ObjNull, [ObjNull]];
private _DisconnectUID = param [1, "", [""]];
private _PlayerName = param [2, "", [""]];

// Exit if player is null or player name is "server"
if (_Player isEqualTo ObjNull || _PlayerName isEqualTo "__SERVER__") exitWith {};

// Read data for save
private _PlayerUID = getPlayerUID _Player;
private _PlayerLoadout = getUnitLoadout _Player;
_PlayerName = name _Player;
private _PlayerLocation = getPosWorld _Player;
private _PlayerHeading = getDir _Player;
private _PlayerTraits = getAllUnitTraits _Player;
private _InVehicle = (vehicle _Player) getVariable ["STNE_database_ID", ""];

// Add _DisconnectUID to _PlayerUID if defined (fix empty uid at disconnect when saving to DB)
if !(_DisconnectUID isEqualTo "") then {
	_PlayerUID = _DisconnectUID;
};

// INIDBI2 save
if ("INIDBI2" in STNE_server_Mods) then {
	["write", [_PlayerUID, "name", _PlayerName]] call INIDBI_players;
	if (missionNamespace getVariable ["STNE_database_PlayerLoadout", false]) then {
		["write", [_PlayerUID, "Loadout", _PlayerLoadout]] call INIDBI_players;
	};
	if (missionNamespace getVariable ["STNE_database_PlayerLocation", false]) then {
		["write", [_PlayerUID, "Location", _PlayerLocation]] call INIDBI_players;
		["write", [_PlayerUID, "Heading", _PlayerHeading]] call INIDBI_players;
	};
	if (missionNamespace getVariable ["STNE_database_PlayerTraits", false]) then {
		["write", [_PlayerUID, "Traits", _PlayerTraits]] call INIDBI_players;
		// ACE mod
		if ("ACE" in STNE_server_Mods) then {
			["write", [_PlayerUID, "ace_medical_medicClass", _Player getVariable ["ace_medical_medicClass", 0]]] call INIDBI_players;
			["write", [_PlayerUID, "ACE_IsEngineer", _Player getVariable ["ACE_IsEngineer", 0]]] call INIDBI_players;
		};
	};
	["write", [_PlayerUID, "InVehicle", _InVehicle]] call INIDBI_players;
};

// Delete player if disconnected
if !(_DisconnectUID isEqualTo "") then {
	deleteVehicle _Player;
};