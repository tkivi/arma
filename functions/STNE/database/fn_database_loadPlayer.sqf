/*
 * Load player from database.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_loadPlayer;
 *
 */

// Params
private _Player = param [0, ObjNull, [ObjNull]];

// Exit if player is null
if (_Player isEqualTo ObjNull) exitWith {};

// Get player UID
private _PlayerUID = getPlayerUID _Player;

// INIDBI2 load
if ("INIDBI2" in STNE_server_Mods) then {
	if ("exists" call INIDBI_players) then {
		private _Sections = "getSections" call INIDBI_players;
		if (_PlayerUID in _Sections) then {
			if (missionNamespace getVariable ["STNE_database_PlayerLoadout", false]) then {
				private _PlayerLoadout = ["read", [_PlayerUID, "Loadout", []]] call INIDBI_players;
				if ((count _PlayerLoadout) > 0) then {
					[_Player, _PlayerLoadout] remoteExec ["setUnitLoadout", _Player];
				};
			};
			if (missionNamespace getVariable ["STNE_database_PlayerLocation", false]) then {
				private _PlayerLocation = ["read", [_PlayerUID, "Location", [0,0,0]]] call INIDBI_players;
				private _PlayerHeading = ["read", [_PlayerUID, "Heading", 0]] call INIDBI_players;
				private _InVehicleID = ["read", [_PlayerUID, "InVehicle", ""]] call INIDBI_players;
				private _InVehicleObject = objNull;
				if !(_InVehicleID isEqualTo "") then {
					{
						if (_x getVariable ["STNE_database_ID", ""] isEqualTo _InVehicleID) exitWith {
							_InVehicleObject = _x;
						};
					} forEach STNE_database_AllObjects;
				};
				if !(_InVehicleObject isEqualTo objNull) then {
					[_Player, _InVehicleObject] remoteExec ["moveInAny", _Player];
				} else {
					[_Player, _PlayerHeading] remoteExec ["setDir", _Player];
					[_Player, _PlayerLocation] remoteExec ["setPosWorld", _Player];
				};
			};
			if (missionNamespace getVariable ["STNE_database_PlayerTraits", false]) then {
				private _PlayerTraits = ["read", [_PlayerUID, "Traits", []]] call INIDBI_players;
				if ((count _PlayerTraits) > 0) then {
					{
						[_Player, [(_x select 0), (_x select 1)]] remoteExec ["setUnitTrait", _Player];
					} forEach _PlayerTraits;
				};
				// ACE mod
				if ("ACE" in STNE_server_Mods) then {
					private _ACE_medic = ["read", [_PlayerUID, "ace_medical_medicClass", 0]] call INIDBI_players;
					private _ACE_engineer = ["read", [_PlayerUID, "ACE_IsEngineer", 0]] call INIDBI_players;
					_Player setVariable ["ace_medical_medicClass", _ACE_medic, true];
					_Player setVariable ["ACE_IsEngineer", _ACE_engineer, true];
				};
			};
		};
	};
};