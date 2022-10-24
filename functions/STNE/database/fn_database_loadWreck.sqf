/*
 * Load wreck from database.
 *
 * Arguments:
 * 0: ObjectID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objectID] call STNE_fnc_database_loadWreck;
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
private _Customization = [[],[]];

// INIDBI2 load
if ("INIDBI2" in STNE_server_Mods) then {
	_Type = ["read", [_ID, "Type", _Type]] call INIDBI_wrecks;
	_Location = ["read", [_ID, "Location", _Location]] call INIDBI_wrecks;
	_VectorDir = ["read", [_ID, "VectorDir", _VectorDir]] call INIDBI_wrecks;
	_VectorUp = ["read", [_ID, "VectorUp", _VectorUp]] call INIDBI_wrecks;
	_Customization = ["read", [_ID, "Customization", _Customization]] call INIDBI_wrecks;
};

// Create object
if !(_Type isEqualTo "") then {
	private _Object = missionNamespace getVariable [_ID, objNull]; // Check if object already exists
	if (_Object isEqualTo objNull) then {
		_Object = _Type createVehicle [0,0,0];
	};
	// Customization
	if !(_Customization isEqualTo [[],[]]) then {
		[_Object, (_Customization select 0), (_Customization select 1)] call BIS_fnc_initVehicle;
	};
	// Location
	_Object setVectorDirAndUp [_VectorDir, _VectorUp];
	_Object setPosWorld _Location;
	// Destroy object
	_Object setfuel 0;
	_Object setFuelCargo 0;
	_Object setVehicleAmmo 0;
	_Object setAmmoCargo 0;
	clearWeaponCargoGlobal _Object;
	clearMagazineCargoGlobal _Object;
	clearItemCargoGlobal _Object;
	clearBackpackCargoGlobal _Object;
	_Object setDamage [1, false];
	// ID
	_Object setVariable ["STNE_database_ID", _ID, true];
	STNE_database_AllObjects pushBackUnique _Object;
};