/*
 * Load and create all mines.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_loadMines;
 *
 */

if ("INIDBI2" in STNE_server_Mods) then {
	private _Mines = ["read", ["Mines", "Mines", []]] call INIDBI_mines;
	{
		private _Mine = createVehicle [(_x select 0), (_x select 1), [], 0, "CAN_COLLIDE"];
		[_Mine, (_x select 2)] remoteExec ["setDir", 0, true];
	} forEach _Mines;
};