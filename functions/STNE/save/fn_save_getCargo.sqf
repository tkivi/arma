/*
 * Get object cargo.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * ARRAY - [[[wpn],[wpn_cnt]],[[mag],[mag_cnt]],[[itm],[itm_cnt]],[[bag],[bag_cnt]]]
 *
 * Example:
 * [cursorObject] call STNE_fnc_save_getCargo;
 *
 */

params ["_object"];
private ["_cargo_wpn_wpn","_cargo_wpn_wpn_1","_cargo_wpn_wpn_2","_cargo_wpn_mag_1","_cargo_wpn_mag_2","_cargo_wpn_itm_1","_cargo_wpn_itm_2","_cargo_mag_mag","_cargo_mag_mag_1","_cargo_mag_mag_2","_cargo_itm_itm","_cargo_itm_itm_1","_cargo_itm_itm_2","_cargo_bag_bag","_cargo_bag_bag_1","_cargo_itm_itm_2","_containers","_object_con","_cargo_wpn_wpn_con","_cargo_wpn_wpn_con_1","_cargo_wpn_wpn_con_2","_cargo_wpn_mag_con_1","_cargo_wpn_mag_con_2","_cargo_wpn_itm_con_1","_cargo_wpn_itm_con_2","_cargo_mag_mag_con","_cargo_mag_mag_con_1","_cargo_mag_mag_con_2","_cargo_itm_itm_con","_cargo_itm_itm_con_1","_cargo_itm_itm_con_2","_cargo_bag_bag_con","_cargo_bag_bag_con_1","_cargo_bag_bag_con_2","_return","_return_wpn_1","_return_wpn_2","_return_mag_1","_return_mag_2","_return_itm_1","_return_itm_2","_return_bag_1","_return_bag_2"];

_return_wpn_1 = [];
_return_wpn_2 = [];
_return_mag_1 = [];
_return_mag_2 = [];
_return_itm_1 = [];
_return_itm_2 = [];
_return_bag_1 = [];
_return_bag_2 = [];

// Get object weapon cargo data [[["wpn"],[count]],[["mag"],[count]],[["itm"],[count]]]
_cargo_wpn_wpn = [_object] call STNE_fnc_save_getCargoWeapon;
_cargo_wpn_wpn_1 = ((_cargo_wpn_wpn select 0) select 0);
_cargo_wpn_wpn_2 = ((_cargo_wpn_wpn select 0) select 1);
_cargo_wpn_mag_1 = ((_cargo_wpn_wpn select 1) select 0);
_cargo_wpn_mag_2 = ((_cargo_wpn_wpn select 1) select 1);
_cargo_wpn_itm_1 = ((_cargo_wpn_wpn select 2) select 0);
_cargo_wpn_itm_2 = ((_cargo_wpn_wpn select 2) select 1);
{_return_wpn_1 pushBack _x;} foreach _cargo_wpn_wpn_1;
{_return_wpn_2 pushBack _x;} foreach _cargo_wpn_wpn_2;

// Get object magazine cargo data [["mag"],[count]] and combine with weapon magazine data
_cargo_mag_mag = [_object] call STNE_fnc_save_getCargoMagazine;
_cargo_mag_mag_1 = (_cargo_mag_mag select 0);
_cargo_mag_mag_2 = (_cargo_mag_mag select 1);
{_return_mag_1 pushBack _x;} foreach _cargo_mag_mag_1;
{_return_mag_2 pushBack _x;} foreach _cargo_mag_mag_2;
{_return_mag_1 pushBack _x;} foreach _cargo_wpn_mag_1;
{_return_mag_2 pushBack _x;} foreach _cargo_wpn_mag_2;

// Get object item cargo data [["itm"],[count]] and combine with weapon item data
_cargo_itm_itm = [_object] call STNE_fnc_save_getCargoItem;
_cargo_itm_itm_1 = (_cargo_itm_itm select 0);
_cargo_itm_itm_2 = (_cargo_itm_itm select 1);
{_return_itm_1 pushBack _x;} foreach _cargo_itm_itm_1;
{_return_itm_2 pushBack _x;} foreach _cargo_itm_itm_2;
{_return_itm_1 pushBack _x;} foreach _cargo_wpn_itm_1;
{_return_itm_2 pushBack _x;} foreach _cargo_wpn_itm_2;

// Get object backbag cargo data [["bag"],[count]]
_cargo_bag_bag = [_object] call STNE_fnc_save_getCargoBackpack;
_cargo_bag_bag_1 = (_cargo_bag_bag select 0);
_cargo_bag_bag_2 = (_cargo_bag_bag select 1);
{_return_bag_1 pushBack _x;} foreach _cargo_bag_bag_1;
{_return_bag_2 pushBack _x;} foreach _cargo_bag_bag_2;

// Read containers data [["class",object],["class",object]]...
_containers = everyContainer _object;
for "_i" from 0 to (count(_containers) - 1) do
{
	_object_con = ((_containers select _i) select 1);

	// Get object weapon cargo data [[["wpn"],[count]],[["mag"],[count]],[["itm"],[count]]] and combine
	_cargo_wpn_wpn_con = [_object_con] call STNE_fnc_save_getCargoWeapon;
	_cargo_wpn_wpn_con_1 = ((_cargo_wpn_wpn_con select 0) select 0);
	_cargo_wpn_wpn_con_2 = ((_cargo_wpn_wpn_con select 0) select 1);
	_cargo_wpn_mag_con_1 = ((_cargo_wpn_wpn_con select 1) select 0);
	_cargo_wpn_mag_con_2 = ((_cargo_wpn_wpn_con select 1) select 1);
	_cargo_wpn_itm_con_1 = ((_cargo_wpn_wpn_con select 2) select 0);
	_cargo_wpn_itm_con_2 = ((_cargo_wpn_wpn_con select 2) select 1);
	{_return_wpn_1 pushBack _x;} foreach _cargo_wpn_wpn_con_1;
	{_return_wpn_2 pushBack _x;} foreach _cargo_wpn_wpn_con_2;

	// Get object magazine cargo data [["mag"],[count]] and combine with weapon magazine data
	_cargo_mag_mag_con = [_object_con] call STNE_fnc_save_getCargoMagazine;
	_cargo_mag_mag_con_1 = (_cargo_mag_mag_con select 0);
	_cargo_mag_mag_con_2 = (_cargo_mag_mag_con select 1);
	{_return_mag_1 pushBack _x;} foreach _cargo_mag_mag_con_1;
	{_return_mag_2 pushBack _x;} foreach _cargo_mag_mag_con_2;
	{_return_mag_1 pushBack _x;} foreach _cargo_wpn_mag_con_1;
	{_return_mag_2 pushBack _x;} foreach _cargo_wpn_mag_con_2;

	// Get object item cargo data [["itm"],[count]] and combine with weapon item data
	_cargo_itm_itm_con = [_object_con] call STNE_fnc_save_getCargoItem;
	_cargo_itm_itm_con_1 = (_cargo_itm_itm_con select 0);
	_cargo_itm_itm_con_2 = (_cargo_itm_itm_con select 1);
	{_return_itm_1 pushBack _x;} foreach _cargo_itm_itm_con_1;
	{_return_itm_2 pushBack _x;} foreach _cargo_itm_itm_con_2;
	{_return_itm_1 pushBack _x;} foreach _cargo_wpn_itm_con_1;
	{_return_itm_2 pushBack _x;} foreach _cargo_wpn_itm_con_2;

	// Get object backbag cargo data [["bag"],[count]]
	_cargo_bag_bag_con = [_object_con] call STNE_fnc_save_getCargoBackpack;
	_cargo_bag_bag_con_1 = (_cargo_bag_bag_con select 0);
	_cargo_bag_bag_con_2 = (_cargo_bag_bag_con select 1);
	{_return_bag_1 pushBack _x;} foreach _cargo_bag_bag_con_1;
	{_return_bag_2 pushBack _x;} foreach _cargo_bag_bag_con_2;
};

_return = [[_return_wpn_1,_return_wpn_2],[_return_mag_1,_return_mag_2],[_return_itm_1,_return_itm_2],[_return_bag_1,_return_bag_2]];
_return;