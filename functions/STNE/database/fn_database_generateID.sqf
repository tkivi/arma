/*
 * Generate ID for object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_database_generateID;
 *
 */

// Params
private _Object = param [0, ObjNull, [ObjNull]];

// Exit if object is null
if (_Object isEqualTo ObjNull) exitWith {};

// Exit if object is man
if (_Object isKindOf "Man") exitWith {};

// Get object ID
private _ObjectID = _Object getVariable ["STNE_database_ID", ""];

// Generate ID
if (_ObjectID isEqualTo "") then {
	if ((vehicleVarName _Object) isEqualTo "") then {
		private _PosWorld = getPosWorld _Object;
		_ObjectID =
			(typeOf _Object)
			+ "_"
			+ str(floor(_PosWorld select 0))
			+ str(floor(_PosWorld select 1))
			+ "_"
			+ str(floor(10 + random 89));
	} else {
		_ObjectID = vehicleVarName _Object;
	};
	_Object setVariable ["STNE_database_ID", _ObjectID, true];
	STNE_database_AllObjects = missionNamespace getVariable ["STNE_database_AllObjects", []];
	STNE_database_AllObjects pushBackUnique _Object;
	publicVariable "STNE_database_AllObjects";
};
_ObjectID;