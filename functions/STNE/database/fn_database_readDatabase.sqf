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

// Array containing all saved objects
STNE_database_AllObjects = [];

private _BuildingIDs = [];
private _StaticIDs = [];
private _ObjectIDs = [];
private _StaticIDsDelayed = [];
private _ObjectIDsDelayed = [];

// INIDBI2 read
if ("INIDBI2" in STNE_server_Mods) then {
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