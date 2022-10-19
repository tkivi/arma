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
	// Send status if remote executed
	if (_SendStatus) then {
		if (isRemoteExecuted) then {
			if !(remoteExecutedOwner isEqualTo 0) then {
				private _Name = format ["Database: %1", missionNamespace getVariable ["STNE_database_Name", ""]];
				private _Players = format ["Players: %1", count ("getSections" call INIDBI_players)];
				private _Objects = format ["Objects: %1", count ("getSections" call INIDBI_objects)];
				private _Statics = format ["Statics: %1", count ("getSections" call INIDBI_statics)];
				private _Buildings = format ["Buildings: %1", count ("getSections" call INIDBI_buildings)];
				[_Name] remoteExec ["systemChat", remoteExecutedOwner];
				[_Players] remoteExec ["systemChat", remoteExecutedOwner];
				[_Objects] remoteExec ["systemChat", remoteExecutedOwner];
				[_Statics] remoteExec ["systemChat", remoteExecutedOwner];
				[_Buildings] remoteExec ["systemChat", remoteExecutedOwner];
			};
		};
	};
};