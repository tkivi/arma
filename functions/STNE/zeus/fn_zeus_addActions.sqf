/*
 * Add actions for Zeus enchanced mod.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_zeus_addActions;
 *
 */

if ("ZEN" in STNE_server_Mods) then {
	{
		call compile preprocessFileLineNumbers format ["functions\STNE\zeus\fn_zeus_action_%1.sqf", _x];
	} forEach [
		"Database"
	];
};