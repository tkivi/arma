/*
 * Set unit init loadout.
 *
 * Arguments:
 * Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [Object] call STNE_fnc_init_setLoadout;
 *
 */

private _Object = param [0, ObjNull, [ObjNull]];
if !(isNull _Object) then {
	if (local _Object) then {
		private _Loadouts = missionNamespace getVariable ["STNE_init_Loadouts_" + (typeOf _Object), []];
		if (count _Loadouts > 0) then {
			_Object setUnitLoadout (selectRandom _Loadouts);
		};
	};
};