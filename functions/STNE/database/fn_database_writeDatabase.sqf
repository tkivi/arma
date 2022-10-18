/*
 * Write data to database.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_writeDatabase;
 *
 */

// INIDBI2 write
if ("INIDBI2" in STNE_server_Mods) then {
	// Players
	{
		[_x] call STNE_fnc_database_savePlayer;
	} forEach playableUnits;
	// Statics and Objects
	if ("exists" call INIDBI_statics) then {"delete" call INIDBI_statics;};
	if ("exists" call INIDBI_objects) then {"delete" call INIDBI_objects;};
	{
		if !(_x getVariable ["STNE_database_ID", ""] isEqualTo "") then {
			if ([_x] call STNE_fnc_database_hasInventory) then { //_x isKindOf "Static"
				[_x] call STNE_fnc_database_saveObject;
			} else {
				[_x] call STNE_fnc_database_saveStatic;
			};
		};			
	} forEach STNE_database_AllObjects;
};