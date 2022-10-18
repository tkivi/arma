/*
 * Save object to database.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_saveObject;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if object is null
if (_Object isEqualTo ObjNull) exitWith {};

// Read data for save
private _ID = _Object getVariable ["STNE_database_ID", ""];
private _Type = typeOf _Object;
private _Location = getPosWorld _Object;
private _VectorDir = vectorDir _Object;
private _VectorUp = vectorUp _Object;
private _Customization = [_Object] call BIS_fnc_getVehicleCustomization;
private _Cargo = [_Object] call STNE_fnc_save_getCargo;
private _CargoWeapons = _Cargo select 0;
private _CargoMagazines = _Cargo select 1;
private _CargoItems = _Cargo select 2;
private _CargoBags = _Cargo select 3;

if !(_ID isEqualTo "") then {
	// INIDBI2 save
	if ("INIDBI2" in STNE_server_Mods) then {
		["write", [_ID, "Type", _Type]] call INIDBI_objects;
		["write", [_ID, "Location", _Location]] call INIDBI_objects;
		["write", [_ID, "VectorDir", _VectorDir]] call INIDBI_objects;
		["write", [_ID, "VectorUp", _VectorUp]] call INIDBI_objects;
		["write", [_ID, "Customization", _Customization]] call INIDBI_objects;
		["write", [_ID, "CargoWeapons", _CargoWeapons]] call INIDBI_objects;
		["write", [_ID, "CargoMagazines", _CargoMagazines]] call INIDBI_objects;
		["write", [_ID, "CargoItems", _CargoItems]] call INIDBI_objects;
		["write", [_ID, "CargoBags", _CargoBags]] call INIDBI_objects;
		if (missionNamespace getVariable ["STNE_database_VehicleStatus", false]) then {
			// Damage, fuel
			private _Damage = damage _Object;
			private _DamageHP = getAllHitPointsDamage _Object;
			private _Fuel = fuel _Object;
			["write", [_ID, "Damage", _Damage]] call INIDBI_objects;
			["write", [_ID, "DamageHP", _DamageHP]] call INIDBI_objects;
			["write", [_ID, "Fuel", _Fuel]] call INIDBI_objects;
			// Pylons
			private _Pylons = [];
			private _PylonMagazines = getPylonMagazines _Object;
			{
				_Pylons pushBack [_x, (_Object ammoOnPylon (_foreachindex + 1))];
			} forEach _PylonMagazines;
			["write", [_ID, "Pylons", _Pylons]] call INIDBI_objects;
			// Magazines, turrets [["className",[turretPath],ammoCount,<id>,<creator>],...]
			private _Magazines = [];
			private _MagazineTurrets = magazinesAllTurrets _Object;
			{
				if !((_x select 0) in _PylonMagazines) then {
					_Magazines append [[_x select 0, _x select 1, _x select 2]];
				};
			} forEach _MagazineTurrets;
			["write", [_ID, "Magazines", _Magazines]] call INIDBI_objects;
		};
		// ACE mod
		if ("ACE" in STNE_server_Mods) then {
			["write", [_ID, "ace_medical_ismedicalvehicle", _Object getVariable ["ace_medical_ismedicalvehicle", false]]] call INIDBI_objects;
			["write", [_ID, "ace_isrepairvehicle", _Object getVariable ["ace_isrepairvehicle", 0]]] call INIDBI_objects;
		};
	};
};