/*
 * Add all playable units as editable objects for all curator modules.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_zeus_addPlayers;
 *
 */

{
	_x addCuratorEditableObjects [playableUnits, true];
} forEach allCurators;