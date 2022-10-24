/*
 * Read data from database.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_readDatabase;
 *
 */

STNE_database_AllObjects = missionNamespace getVariable ["STNE_database_AllObjects", []];

private _BuildingIDs = [];
private _StaticIDs = [];
private _ObjectIDs = [];
private _StaticIDsDelayed = [];
private _ObjectIDsDelayed = [];

// INIDBI2 read
if ("INIDBI2" in STNE_server_Mods) then {
	// Markers
	if ("exists" call INIDBI_markers) then {
		[] call STNE_fnc_database_loadMarkers;
	};
	// Mines
	if (missionNamespace getVariable ["STNE_database_Mines", false]) then {
		// Read editor placed mines, need sleep to detect mines added by editor module
		sleep 1;
		STNE_editor_Mines = allMines;
		if ("exists" call INIDBI_mines) then {
			[] call STNE_fnc_database_loadMines;
		};
	};
	// Buildings
	if ("exists" call INIDBI_buildings) then {
		private _BuildingIDs = "getSections" call INIDBI_buildings;
		{
			[_x] call STNE_fnc_database_loadBuilding;
		} forEach _BuildingIDs;
	};
	// Statics
	if ("exists" call INIDBI_statics) then {
		private _StaticIDs = "getSections" call INIDBI_statics;
		{
			if (!((["read", [_x, "CargoVehicleViV", ""]] call INIDBI_statics) isEqualTo "") || !((["read", [_x, "CargoVehicleACE", ""]] call INIDBI_statics) isEqualTo "")) then {
				_StaticIDsDelayed pushBack _x;
			} else {
				[_x] call STNE_fnc_database_loadStatic;
			};
		} forEach _StaticIDs;
	};
	// Wrecks
	if ("exists" call INIDBI_wrecks) then {
		private _WreckIDs = "getSections" call INIDBI_wrecks;
		{
			[_x] call STNE_fnc_database_loadWreck;
		} forEach _WreckIDs;
	};
	// Objects
	if ("exists" call INIDBI_objects) then {
		private _ObjectIDs = "getSections" call INIDBI_objects;
		{
			if (!((["read", [_x, "CargoVehicleViV", ""]] call INIDBI_objects) isEqualTo "") || !((["read", [_x, "CargoVehicleACE", ""]] call INIDBI_objects) isEqualTo "")) then {
				_ObjectIDsDelayed pushBack _x;
			} else {
				[_x] call STNE_fnc_database_loadObject;
			};
		} forEach _ObjectIDs;
	};
	// Delayed load
	{
		[_x] call STNE_fnc_database_loadObject;
	} forEach _ObjectIDsDelayed;
	{
		[_x] call STNE_fnc_database_loadStatic;
	} forEach _StaticIDsDelayed;
};

publicVariable "STNE_database_AllObjects";