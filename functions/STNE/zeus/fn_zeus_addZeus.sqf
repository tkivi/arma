/*
 * Add Zeus to player if defined in config.
 *
 * Arguments:
 * Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] spawn STNE_fnc_zeus_addZeus;
 *
 */

private _Player = param [0, ObjNull, [ObjNull]];

// Initial delay
sleep 5;

if (isNull (getAssignedCuratorLogic _Player)) then {
	// Add Zeus if defined
	private _PlayerUID = getPlayerUID _Player;
	private _Sandbox = missionNamespace getVariable ["STNE_sandbox_Zeus", false];
	private _SqfUID = missionNamespace getVariable ["STNE_zeus_PlayerUID", []];
	private _ExtUID = getMissionConfigValue ["enableDebugConsole", []];

	if (_Sandbox || (_PlayerUID in _SqfUID) || (_PlayerUID in _ExtUID)) then {
		if ("ZEN" in STNE_server_Mods) then {
			while {sleep 3; (isNull (getAssignedCuratorLogic _Player))} do {
				_Player call zen_common_fnc_createZeus;
			};
		};
	};
};

// Add players as editable objects
if ("BLINDZEUS" in STNE_server_Mods) then {
	// BlindZeus mod enabled, skip
} else {
	[] call STNE_fnc_zeus_addPlayers;
};