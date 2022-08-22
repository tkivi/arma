/*
 * Add Zeus to player if defined in config.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] spawn STNE_fnc_zeus_addZeus;
 *
 */

if (isNull (getAssignedCuratorLogic player)) then {
	// Add Zeus if defined
	private _PlayerUID = getPlayerUID player;
	private _Sandbox = missionNamespace getVariable ["STNE_sandbox_Enabled", false];
	private _SqfUID = missionNamespace getVariable ["STNE_zeus_PlayerUID", []];
	private _ExtUID = getMissionConfigValue ["enableDebugConsole", []];

	if (_Sandbox || (_PlayerUID in _SqfUID) || (_PlayerUID in _ExtUID)) then {
		if ("ZEN" in STNE_server_Mods) then {
			while {sleep 5; (isNull (getAssignedCuratorLogic player))} do {
				[player] remoteExec ["zen_common_fnc_createZeus", 2];
			};
		};
	};
};

// Add players as editable objects
if ("BLINDZEUS" in STNE_server_Mods) then {
	// BlindZeus mod enabled, skip
} else {
	[] remoteExec ["STNE_fnc_zeus_addPlayers", 2];
};