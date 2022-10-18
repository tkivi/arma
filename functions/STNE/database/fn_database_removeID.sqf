/*
 * Remove ID from object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_removeID;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if object is null
if (_Object isEqualTo ObjNull) exitWith {};

// Get object ID
_ObjectID = _Object getVariable ["STNE_database_ID", ""];

// Remove ID
if !(_ObjectID isEqualTo "") then {
	_Object setVariable ["STNE_database_ID", nil, true];
	STNE_database_AllObjects = STNE_database_AllObjects - [_Object];
	publicVariable "STNE_database_AllObjects";
};
_ObjectID;