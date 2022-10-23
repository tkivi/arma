/*
 * Load building from database.
 *
 * Arguments:
 * 0: BuildingID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objectID] call STNE_fnc_database_loadBuilding;
 *
 */

// Params
private _ID = param [0, "", [""]];

// Exit if objectID is ""
if (_ID isEqualTo "") exitWith {};

// Defaults
private _Type = "";
private _Location = [0,0,0];
private _VectorDir = [0,0,0];
private _VectorUp = [0,0,0];
private _Building = "";

// INIDBI2 load
if ("INIDBI2" in STNE_server_Mods) then {
	_Type = ["read", [_ID, "Type", _Type]] call INIDBI_buildings;
	_Location = ["read", [_ID, "Location", _Location]] call INIDBI_buildings;
	_VectorDir = ["read", [_ID, "VectorDir", _VectorDir]] call INIDBI_buildings;
	_VectorUp = ["read", [_ID, "VectorUp", _VectorUp]] call INIDBI_buildings;
	_Building = ["read", [_ID, "Building", _Building]] call INIDBI_buildings;
};

// Create object
if !(_Type isEqualTo "") then {
	if (_Building isEqualTo "") then {
		(nearestObject [_Location select 0, _Location select 1, 0]) hideObjectGlobal true;
	} else {
		(nearestObject [_Location, _Building]) hideObjectGlobal true;
	};
	private _Object = _Type createVehicle [0,0,0];
	_Object setVectorDirAndUp [_VectorDir, _VectorUp];
	_Object setPosWorld _Location;
	_Object setVariable ["STNE_database_ID", _ID, true];
	if !(_Building isEqualTo "") then {
		_Object setVariable ["STNE_database_Building", _Building, true];
	};
	STNE_database_AllObjects pushBackUnique _Object;
};