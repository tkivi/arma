/*
 * Add ACE Fortify objects.
 *
 * Arguments:
 * Class names <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["className", "className"]] call STNE_fnc_server_addFortifyACE;
 *
 */

// Params
private _Objects = param [0, [], []];

if ((count _Objects) isEqualTo 0) exitWith {};

if ("CBA" in STNE_server_Mods && "ACE" in STNE_server_Mods) then {
	// Add fortify objects
	{
		[
			_x,
			-1,
			_Objects apply {[_x, 0]}
		] call ace_fortify_fnc_registerObjects;
	} forEach [west, east, independent, civilian];
	// Database, register objects
	{
		if ((typeOf _x) in _Objects) then {
			["acex_fortify_objectPlaced", [objNull, west, _x]] call CBA_fnc_globalEvent;
		};
	} forEach (missionNamespace getVariable ["STNE_database_AllObjects", []]);
	// Database, track fortify objects
	if (missionNamespace getVariable ["STNE_database_TrackFortify", false]) then {
		["acex_fortify_objectPlaced", {
				[_this select 2] call STNE_fnc_database_generateID;
			}
		] call CBA_fnc_addEventHandler;
	};
};