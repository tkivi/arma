/*
 * Load static from database.
 *
 * Arguments:
 * 0: StaticID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objectID] call STNE_fnc_database_loadStatic;
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
private _CargoVehicleViV = "";
private _CargoVehicleACE = "";

// INIDBI2 load
if ("INIDBI2" in STNE_server_Mods) then {
	_Type = ["read", [_ID, "Type", _Type]] call INIDBI_statics;
	_Location = ["read", [_ID, "Location", _Location]] call INIDBI_statics;
	_VectorDir = ["read", [_ID, "VectorDir", _VectorDir]] call INIDBI_statics;
	_VectorUp = ["read", [_ID, "VectorUp", _VectorUp]] call INIDBI_statics;
	_CargoVehicleViV = ["read", [_ID, "CargoVehicleViV", _CargoVehicleViV]] call INIDBI_statics;
};

// Create object
if !(_Type isEqualTo "") then {
	private _Object = missionNamespace getVariable [_ID, objNull]; // Check if object already exists
	if (_Object isEqualTo objNull) then {
		_Object = _Type createVehicle [0,0,0];
	};
	// ACE mod
	if ("ACE" in STNE_server_Mods && "INIDBI2" in STNE_server_Mods) then {
		private _ACE_medical = ["read", [_ID, "ace_medical_ismedicalfacility", false]] call INIDBI_statics;
		private _ACE_engineer = ["read", [_ID, "ace_isrepairfacility", 0]] call INIDBI_statics;
		_CargoVehicleACE = ["read", [_ID, "CargoVehicleACE", _CargoVehicleACE]] call INIDBI_statics;
		_Object setVariable ["ace_medical_ismedicalfacility", _ACE_medical, true];
		_Object setVariable ["ace_isrepairfacility", _ACE_engineer, true];
	};
	// Location
	if (_CargoVehicleViV isEqualTo "") then {
		if ("ACE" in STNE_server_Mods && !(_CargoVehicleACE isEqualTo "")) then {
			{
				if (_x getVariable ["STNE_database_ID", ""] isEqualTo _CargoVehicleACE) exitWith {
					[_Object, _x, true] call ace_cargo_fnc_loadItem;
				};
			} forEach STNE_database_AllObjects;
		} else {
			_Object setVectorDirAndUp [_VectorDir, _VectorUp];
			_Object setPosWorld _Location;
		};
	} else {
		{
			if (_x getVariable ["STNE_database_ID", ""] isEqualTo _CargoVehicleViV) exitWith {
				_x setVehicleCargo _Object;
			};
		} forEach STNE_database_AllObjects;
	};
	_Object setVariable ["STNE_database_ID", _ID, true];
	STNE_database_AllObjects pushBackUnique _Object;
};