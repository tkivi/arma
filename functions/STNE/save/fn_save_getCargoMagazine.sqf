/*
 * Get object magazine cargo.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * ARRAY - [[magazine],[count]]
 *
 * Example:
 * [cursorObject] call STNE_fnc_save_getCargoMagazine;
 *
 */

 params ["_object"];
private ["_return"];

_return = getMagazineCargo _object;
_return;