/*
 * Get object type number.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Number <NUMBER>
 *
 * Example:
 * [object] call STNE_fnc_database_getType;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if object is null
if (_Object isEqualTo ObjNull) exitWith {};

// Default
private _Type = 0;

// Static
if (_x isKindOf "Static") then {
	_Type = 2;
};

// Building
if (_x isKindOf "Ruins") then {
	_Type = 3;
};

// Object with inventory
if ([_Object] call STNE_fnc_database_hasInventory) then {
	if ((damage _Object) isEqualTo 1) then {
		_Type = 4;
	} else {
		_Type = 1;
	};
};

_Type;