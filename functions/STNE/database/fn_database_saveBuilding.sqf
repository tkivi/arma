/*
 * Save building to database.
 *
 * Arguments:
 * 0: Building <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_saveBuilding;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if building is null
if (_Object isEqualTo ObjNull) exitWith {};

// Read data for save
private _ID = _Object getVariable ["STNE_database_ID", ""];;
private _Type = typeOf _Object;
private _Location = getPosWorld _Object;
private _VectorDir = vectorDir _Object;
private _VectorUp = vectorUp _Object;
private _Building = _Object getVariable ["STNE_database_Building", ""];

if !(_ID isEqualTo "") then {
	// INIDBI2 save
	if ("INIDBI2" in STNE_server_Mods) then {
		["write", [_ID, "Type", _Type]] call INIDBI_buildings;
		["write", [_ID, "Location", _Location]] call INIDBI_buildings;
		["write", [_ID, "VectorDir", _VectorDir]] call INIDBI_buildings;
		["write", [_ID, "VectorUp", _VectorUp]] call INIDBI_buildings;
		["write", [_ID, "Building", _Building]] call INIDBI_buildings;
	};
};