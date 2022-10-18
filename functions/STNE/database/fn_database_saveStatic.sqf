/*
 * Save static to database.
 *
 * Arguments:
 * 0: Static <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_saveStatic;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if static is null
if (_Object isEqualTo ObjNull) exitWith {};

// Read data for save
private _ID = _Object getVariable ["STNE_database_ID", ""];;
private _Type = typeOf _Object;
private _Location = getPosWorld _Object;
private _VectorDir = vectorDir _Object;
private _VectorUp = vectorUp _Object;

if !(_ID isEqualTo "") then {
	// INIDBI2 save
	if ("INIDBI2" in STNE_server_Mods) then {
		["write", [_ID, "Type", _Type]] call INIDBI_statics;
		["write", [_ID, "Location", _Location]] call INIDBI_statics;
		["write", [_ID, "VectorDir", _VectorDir]] call INIDBI_statics;
		["write", [_ID, "VectorUp", _VectorUp]] call INIDBI_statics;
		// ACE mod
		if ("ACE" in STNE_server_Mods) then {
			["write", [_ID, "ace_medical_ismedicalfacility", _Object getVariable ["ace_medical_ismedicalfacility", false]]] call INIDBI_statics;
			["write", [_ID, "ace_isrepairfacility", _Object getVariable ["ace_isrepairfacility", 0]]] call INIDBI_statics;
		};
	};
};