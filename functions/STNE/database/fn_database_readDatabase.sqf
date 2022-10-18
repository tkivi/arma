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

// Array containing all saved statics and objects
STNE_database_AllObjects = [];

// INIDBI2 read
if ("INIDBI2" in STNE_server_Mods) then {
	if ("exists" call INIDBI_statics) then {
		private _Sections = "getSections" call INIDBI_statics;
		{
			[_x] call STNE_fnc_database_loadStatic;
		} forEach _Sections;
	};
	if ("exists" call INIDBI_objects) then {
		private _Sections = "getSections" call INIDBI_objects;
		{
			[_x] call STNE_fnc_database_loadObject;
		} forEach _Sections;
	};
};

publicVariable "STNE_database_AllObjects";