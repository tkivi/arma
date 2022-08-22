/*
 * Get object backpack cargo.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * ARRAY - [[backpack],[count]]
 *
 * Example:
 * [cursorObject] call STNE_fnc_save_getCargoBackpack;
 *
 */

params ["_object"];
private ["_return","_bag_list","_bag_basic_list"];

_bag_list = getBackpackCargo _object;
_bag_basic_list = [];

// Get basic backpack class names
{
	_bag_basic_list pushBack (_x call BIS_fnc_basicBackpack);
} foreach (_bag_list select 0);

_return = [_bag_basic_list] + [(_bag_list select 1)];
_return;