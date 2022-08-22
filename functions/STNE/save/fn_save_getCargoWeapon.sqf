/*
 * Get object weapon cargo.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * ARRAY - [[[wpn],[wpn_cnt]],[[mag],[mag_cnt]],[[itm],[itm_cnt]]]
 *
 * Example:
 * [cursorObject] call STNE_fnc_save_getCargoWeapon;
 *
 */

 params ["_object"];
private ["_full_wpn_list","_wpn_list","_wpn_basic_list","_mag_list","_itm_list","_item_count","_count_array","_return"];

_full_wpn_list = weaponsItemscargo _object;
_wpn_list = getWeaponCargo _object;
_wpn_basic_list = [];
_mag_list = [];
_itm_list = [];

if (_wpn_list isEqualTo [[],[]]) exitWith
{
	_return = [[[],[]],[[],[]],[[],[]]];
	_return;
};

// Get weapon basic names
{
	_wpn_basic_list pushBack ([_x] call BIS_fnc_baseWeapon);
} foreach (_wpn_list select 0);
_wpn_basic_list = [_wpn_basic_list] + [(_wpn_list select 1)];

// Get magazines from weapon
for "_i" from 0 to (count(_full_wpn_list) - 1) do
{
	if (count(_full_wpn_list select _i) <= 6) then
	{
		_mag_list pushBack (((_full_wpn_list select _i) select 4) select 0);
	}
	else
	{
		_mag_list pushBack (((_full_wpn_list select _i) select 4) select 0);
		_mag_list pushBack (((_full_wpn_list select _i) select 5) select 0);
	};
};
_mag_list = _mag_list - [""];
_mag_list = _mag_list - [nil];
_item_count = count(_mag_list);
_count_array = [];
_count_array resize _item_count;
_count_array = _count_array apply {1};
_mag_list = [_mag_list];
_mag_list pushBack _count_array;

// Get items from weapon
for "_i" from 0 to (count(_full_wpn_list) - 1) do
{
	_itm_list pushBack ((_full_wpn_list select _i) select 1);
	_itm_list pushBack ((_full_wpn_list select _i) select 2);
	_itm_list pushBack ((_full_wpn_list select _i) select 3);

	if (count(_full_wpn_list select _i) <= 6) then
	{
		_itm_list pushBack ((_full_wpn_list select _i) select 5);
	}
	else
	{
		_itm_list pushBack ((_full_wpn_list select _i) select 6);
	};
};
_itm_list = _itm_list - [""];
_itm_list = _itm_list - [nil];
_item_count = count(_itm_list);
_count_array = [];
_count_array resize _item_count;
_count_array = _count_array apply {1};
_itm_list = [_itm_list];
_itm_list pushBack _count_array;

_return = [_wpn_basic_list,_mag_list,_itm_list];
_return;