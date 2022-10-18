/*
 * Check if object has inventory.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [object] call STNE_fnc_database_hasInventory;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if object is null
if (_Object isEqualTo ObjNull) exitWith {};

private _Type = typeOf _Object;
private _HasInventory = false;

// ACE mod
private _ACE_cargo = false;
if ("ACE" in STNE_server_Mods) then {
	_ACE_cargo = (getNumber (configfile >> "CfgVehicles" >> _Type >> "ace_cargo_space")) > 0;
};

// Get possible inventory space
if (getNumber (configFile >> "CfgVehicles" >> _Type >> "transportmaxbackpacks") > 0 ||
	getNumber (configFile >> "CfgVehicles" >> _Type >> "transportmaxmagazines") > 0 ||
	getNumber (configFile >> "CfgVehicles" >> _Type >> "transportmaxweapons") > 0 ||
	count (getArray (configfile >> "CfgVehicles" >> _Type >> "magazines")) > 0 ||
	count (getArray (configfile >> "CfgVehicles" >> _Type >> "weapons")) > 0 ||
	vehicleCargoEnabled _Object ||
	_ACE_cargo) then {
		_HasInventory = true;
	};
_HasInventory;