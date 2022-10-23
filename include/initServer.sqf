// Sandbox Arsenal
if (missionNamespace getVariable ["STNE_sandbox_Arsenal", false]) then {
	[] call STNE_fnc_arsenal_addSandbox;
};

// Set server viewDistance
if ((missionNamespace getVariable ["STNE_server_ViewDistance", 0]) > 0) then {
	[STNE_server_ViewDistance] call STNE_fnc_server_setViewDistance;
};

// Persistent database
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		private _DatabaseName = missionNamespace getVariable ["STNE_database_Name", ""];
		INIDBI_players = ["new", (_DatabaseName + "_" + worldName + "_players")] call OO_INIDBI;		// 0 - Players
		INIDBI_objects = ["new", (_DatabaseName + "_" + worldName + "_objects")] call OO_INIDBI;		// 1 - Objects with inventory
		INIDBI_statics = ["new", (_DatabaseName + "_" + worldName + "_statics")] call OO_INIDBI;		// 2 - Simple static objects
		INIDBI_buildings = ["new", (_DatabaseName + "_" + worldName + "_buildings")] call OO_INIDBI;	// 3 - Destroyed buildings on map
		INIDBI_map = ["new", (_DatabaseName + "_" + worldName + "_map")] call OO_INIDBI;				// 4 - Map markers, mines, etc..
		// Handle player disconnect
		if (missionNamespace getVariable ["STNE_database_SaveAtDisconnect", false]) then {
			addMissionEventHandler ["HandleDisconnect", {[(_this select 0), (_this select 2), (_this select 3)] call STNE_fnc_database_savePlayer;}];
		};
		// Handle mission end
		if (missionNamespace getVariable ["STNE_database_SaveAtEnd", false]) then {
			addMissionEventHandler ["Ended", {[] call STNE_fnc_database_writeDatabase;}];
			addMissionEventHandler ["MPEnded", {[] call STNE_fnc_database_writeDatabase;}];
		};
		// Track building status on map
		if (missionNamespace getVariable ["STNE_database_TrackBuilding", false]) then {
			addMissionEventHandler ["BuildingChanged", {
				private _Building = (_this select 0) getVariable ["STNE_database_Building", ""];
				if (_Building isEqualTo "") then {
					(_this select 1) setVariable ["STNE_database_Building", (typeOf (_this select 0)), true];
				} else {
					(_this select 1) setVariable ["STNE_database_Building", _Building, true];
				};
				[_this select 0] call STNE_fnc_database_removeID;
				[_this select 1] call STNE_fnc_database_generateID;
			}];
		};
		// Read database
		[] call STNE_fnc_database_readDatabase;
	};
};

// Server init is done
STNE_server_Init = true;
publicVariable "STNE_server_Init";

// Bug fix: https://feedback.bistudio.com/T126030
// MPclient can't take items in deadbody's vest/uniform/bag When change equipments on eden.
{
	_x setUnitLoadout (getUnitLoadout _x);
} forEach (allUnits - playableUnits);