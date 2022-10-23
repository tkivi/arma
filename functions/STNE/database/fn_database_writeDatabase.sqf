/*
 * Write data to database.
 *
 * Arguments:
 * Send status <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_writeDatabase;
 *
 */

private _SendStatus = param [0, false, [false]];

// INIDBI2 write
if ("INIDBI2" in STNE_server_Mods) then {
	// Players
	{
		[_x] call STNE_fnc_database_savePlayer;
	} forEach playableUnits;
	// Objects, Statics, Buildings
	if ("exists" call INIDBI_objects) then {"delete" call INIDBI_objects;};
	if ("exists" call INIDBI_statics) then {"delete" call INIDBI_statics;};
	if ("exists" call INIDBI_buildings) then {"delete" call INIDBI_buildings;};
	{
		if !(_x getVariable ["STNE_database_ID", ""] isEqualTo "") then {
			switch ([_x] call STNE_fnc_database_getType) do {
				case 1: {[_x] call STNE_fnc_database_saveObject;};
				case 2: {[_x] call STNE_fnc_database_saveStatic;};
				case 3: {[_x] call STNE_fnc_database_saveBuilding;};
				default {[_x] call STNE_fnc_database_saveStatic;};
			};
		};			
	} forEach STNE_database_AllObjects;
	// Mines
	if (missionNamespace getVariable ["STNE_database_Mines", false]) then {
		[] call STNE_fnc_database_saveMines;
	};
	// Markers
	if (missionNamespace getVariable ["STNE_database_Markers", false]) then {
		[] call STNE_fnc_database_saveMarkers;
	};
	// Send status if remote executed
	if (_SendStatus) then {
		if (isRemoteExecuted) then {
			if !(remoteExecutedOwner isEqualTo 0) then {
				private _Header = format ["Database: %1", missionNamespace getVariable ["STNE_database_Name", ""]];
				private _Message = format [
					"Players: %1 | Objects: %2 | Statics: %3 | Buildings: %4 | Markers: %5 | Mines: %6",
					count ("getSections" call INIDBI_players),
					count ("getSections" call INIDBI_objects),
					count ("getSections" call INIDBI_statics),
					count ("getSections" call INIDBI_buildings),
					(count (["read", ["Markers", "Markers", []]] call INIDBI_map)) + (count (["read", ["Markers", "Polylines", []]] call INIDBI_map)),
					count (["read", ["Mines", "Mines", []]] call INIDBI_map)
				];
				[_Header] remoteExec ["systemChat", remoteExecutedOwner];
				[_Message] remoteExec ["systemChat", remoteExecutedOwner];
			};
		};
	};
};