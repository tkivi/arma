/*
 * Load object from database.
 *
 * Arguments:
 * 0: ObjectID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objectID] call STNE_fnc_database_loadObject;
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
private _CargoWeapons = [[],[]];
private _CargoMagazines = [[],[]];
private _CargoItems = [[],[]];
private _CargoBags = [[],[]];
private _Fuel = 1;
private _FuelCargo = -1;
private _AmmoCargo = -1;
private _RepairCargo = -1;
private _Damage = 0;
private _DamageHP = [];
private _Pylons = [];
private _Magazines = [];
private _CargoVehicleViV = "";
private _CargoVehicleACE = "";

// INIDBI2 load
if ("INIDBI2" in STNE_server_Mods) then {
	_Type = ["read", [_ID, "Type", _Type]] call INIDBI_objects;
	_Location = ["read", [_ID, "Location", _Location]] call INIDBI_objects;
	_VectorDir = ["read", [_ID, "VectorDir", _VectorDir]] call INIDBI_objects;
	_VectorUp = ["read", [_ID, "VectorUp", _VectorUp]] call INIDBI_objects;
	_Customization = ["read", [_ID, "Customization", _Customization]] call INIDBI_objects;
	_CargoWeapons = ["read", [_ID, "CargoWeapons", _CargoWeapons]] call INIDBI_objects;
	_CargoMagazines = ["read", [_ID, "CargoMagazines", _CargoMagazines]] call INIDBI_objects;
	_CargoItems = ["read", [_ID, "CargoItems", _CargoItems]] call INIDBI_objects;
	_CargoBags = ["read", [_ID, "CargoBags", _CargoBags]] call INIDBI_objects;
	_CargoVehicleViV = ["read", [_ID, "CargoVehicleViV", _CargoVehicleViV]] call INIDBI_objects;
	if (missionNamespace getVariable ["STNE_database_VehicleStatus", false]) then {
		_Fuel = ["read", [_ID, "Fuel", _Fuel]] call INIDBI_objects;
		_FuelCargo = ["read", [_ID, "FuelCargo", _FuelCargo]] call INIDBI_objects;
		_AmmoCargo = ["read", [_ID, "AmmoCargo", _AmmoCargo]] call INIDBI_objects;
		_RepairCargo = ["read", [_ID, "RepairCargo", _RepairCargo]] call INIDBI_objects;
		_Damage = ["read", [_ID, "Damage", _Damage]] call INIDBI_objects;
		_DamageHP = ["read", [_ID, "DamageHP", _DamageHP]] call INIDBI_objects;
		_Pylons = ["read", [_ID, "Pylons", _Pylons]] call INIDBI_objects;
		_Magazines = ["read", [_ID, "Magazines", _Magazines]] call INIDBI_objects;
	};
};

// Create object
if !(_Type isEqualTo "") then {
	private _Object = missionNamespace getVariable [_ID, objNull]; // Check if object already exists
	if (_Object isEqualTo objNull) then {
		_Object = _Type createVehicle [0,0,0];
	};
	if !(_Type isEqualTo "GroundWeaponHolder") then {
		// Customization
		if !(_Customization isEqualTo [[],[]]) then {
			[_Object, (_Customization select 0), (_Customization select 1)] call BIS_fnc_initVehicle;
		};
		// Clear object cargo
		clearWeaponCargoGlobal _Object;
		clearMagazineCargoGlobal _Object;
		clearItemCargoGlobal _Object;
		clearBackpackCargoGlobal _Object;
	};
	// Add weapons, magazines, items and backpacks to object cargo
	for "_i" from 0 to (count(_CargoWeapons select 0) - 1) do {
		_Object addWeaponCargoGlobal [((_CargoWeapons select 0) select _i), ((_CargoWeapons select 1) select _i)];
	};
	for "_i" from 0 to (count(_CargoMagazines select 0) - 1) do {
		_Object addMagazineCargoGlobal [((_CargoMagazines select 0) select _i), ((_CargoMagazines select 1) select _i)];
	};
	for "_i" from 0 to (count(_CargoItems select 0) - 1) do {
		_Object addItemCargoGlobal [((_CargoItems select 0) select _i), ((_CargoItems select 1) select _i)];
	};
	for "_i" from 0 to (count(_CargoBags select 0) - 1) do {
		_Object addBackpackCargoGlobal [((_CargoBags select 0) select _i), ((_CargoBags select 1) select _i)];
	};
	// Vehicle status
	if (missionNamespace getVariable ["STNE_database_VehicleStatus", false]) then {
		// Damage, fuel
		if !(_Fuel isEqualTo 1) then {_Object setFuel _Fuel;};
		if !(_FuelCargo isEqualTo -1) then {_Object setFuelCargo _FuelCargo;};
		if !(_AmmoCargo isEqualTo -1) then {_Object setAmmoCargo _AmmoCargo;};
		if !(_RepairCargo isEqualTo -1) then {_Object setRepairCargo _RepairCargo;};
		if !(_Damage isEqualTo 0) then {_Object setDamage _Damage;};
		if !(_DamageHP isEqualTo []) then {
			for "_i" from 0 to (count (_DamageHP select 2) - 1) do {
				_Object setHitIndex [_i, ((_DamageHP select 2) select _i)];
			};
		};
		// Remove old pylons and magazines
		if ((count (magazinesAllTurrets _Object)) > 0) then {
			{
				_Object removeMagazineTurret [_x select 0, _x select 1];
			} forEach magazinesAllTurrets _Object;
		};
		if !((count (getPylonMagazines _Object)) isEqualTo 0) then {
			{
				_Object setPylonLoadOut [(_foreachindex + 1), ""];
			} forEach getPylonMagazines _Object;
		};
		// Pylons
		if !(_Pylons isEqualTo []) then {
			{
				_Object setPylonLoadOut [(_foreachindex + 1), (_x select 0), true];
				_Object setAmmoOnPylon [(_foreachindex + 1), (_x select 1)];
			} forEach _Pylons;
		};
		// Magazines
		{
			_Object addMagazineTurret _x;
		} forEach _Magazines;
	};
	// ACE mod
	if ("ACE" in STNE_server_Mods && "INIDBI2" in STNE_server_Mods) then {
		private _ACE_cargo = ["read", [_ID, "ace_cargo_loaded", []]] call INIDBI_objects;
		private _ACE_medical = ["read", [_ID, "ace_medical_ismedicalvehicle", false]] call INIDBI_objects;
		private _ACE_repair = ["read", [_ID, "ace_isrepairvehicle", 0]] call INIDBI_objects;
		_CargoVehicleACE = ["read", [_ID, "CargoVehicleACE", _CargoVehicleACE]] call INIDBI_objects;
		{
			[_x, _Object, true] call ace_cargo_fnc_loadItem;
		} forEach _ACE_cargo;
		_Object setVariable ["ace_medical_ismedicalvehicle", _ACE_medical, true];
		_Object setVariable ["ace_isrepairvehicle", _ACE_repair, true];
		if (missionNamespace getVariable ["STNE_database_VehicleStatus", false]) then {
			private _ACE_fuelcargo = ["read", [_ID, "ace_refuel_fnc_setFuel", 0]] call INIDBI_objects;
			[_Object, _ACE_fuelcargo] call ace_refuel_fnc_setFuel;
		};
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