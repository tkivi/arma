// Sandbox Arsenal
if (missionNamespace getVariable ["STNE_sandbox_Arsenal", false]) then {
	[] call STNE_fnc_arsenal_addSandbox;
};

// Set server viewDistance
if ((missionNamespace getVariable ["STNE_server_ViewDistance", 0]) > 0) then {
	[STNE_server_ViewDistance] call STNE_fnc_server_setViewDistance;
};

// Persistent database
if ("INIDBI2" in STNE_server_Mods) then {
	INIDBI_players = ["new", (missionName + "_players." + worldName)] call OO_INIDBI; // Players
	INIDBI_objects = ["new", (missionName + "_objects." + worldName)] call OO_INIDBI; // Objects with inventory
	INIDBI_statics = ["new", (missionName + "_statics." + worldName)] call OO_INIDBI; // Simple static objects
	// Handle player disconnect
	if (missionNamespace getVariable ["STNE_database_SaveAtDisconnect", false]) then {
		addMissionEventHandler ["HandleDisconnect", {[(_this select 0), (_this select 2), (_this select 3)] call STNE_fnc_database_savePlayer;}];
	};
	// Handle mission end
	if (missionNamespace getVariable ["STNE_database_SaveAtEnd", false]) then {
		addMissionEventHandler ["Ended", {[] call STNE_fnc_database_writeDatabase;}];
		addMissionEventHandler ["MPEnded", {[] call STNE_fnc_database_writeDatabase;}];
	};
	// Read database
	[] call STNE_fnc_database_readDatabase;
};

// Server init is done
STNE_server_Init = true;
publicVariable "STNE_server_Init";

// Bug fix: https://feedback.bistudio.com/T126030
// MPclient can't take items in deadbody's vest/uniform/bag When change equipments on eden.
{
	_x setUnitLoadout (getUnitLoadout _x);
} forEach (allUnits - playableUnits);