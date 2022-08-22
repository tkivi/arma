/*
 * Get object item cargo.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * ARRAY - [[item],[count]]
 *
 * Example:
 * [cursorObject] call STNE_fnc_save_getCargoItem;
 *
 */

 params ["_object"];
private ["_return"];

_return = getItemCargo _object;
_return;