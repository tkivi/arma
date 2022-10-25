/*/////////////////////////////////////////////////////////////////////////////////////

	Parameters:

	[player:Object, didJIP:Boolean]

/////////////////////////////////////////////////////////////////////////////////////*/

// Wait until server init is done
waitUntil {sleep 1; !(isNil "STNE_server_Init")};

// Get player object
private _Player = param [0, ObjNull, [ObjNull]];

// Persistent database
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		[_Player] call STNE_fnc_database_loadPlayer;
		[["", "BLACK IN", 1]] remoteExec ["titleText", _Player];
	};
};

// Assign player object as curator if defined
[_Player] spawn STNE_fnc_zeus_addZeus;