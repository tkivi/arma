/*
 * Save placed mines on map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_saveMines;
 *
 */

private _Mines = [];
{
	_Mines pushBack [(typeOf _x), [((getPosATL _x) select 0), ((getPosATL _x) select 1), 0], (getDir _x)];
} forEach (allMines - (missionNamespace getVariable ["STNE_editor_Mines", []]));

if ("INIDBI2" in STNE_server_Mods) then {
	["write", ["Mines", "Mines", _Mines]] call INIDBI_mines;
};