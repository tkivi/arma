/*
 * Load and create player map markers.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_loadMarkers;
 *
 */

/*if ("INIDBI2" in STNE_server_Mods) then {
	private _Markers = ["read", ["Markers", "Markers", []]] call INIDBI_map;
	private _StartIndex = count (allMapMarkers select {"_USER_DEFINED" in _x});
	{
		private _MarkerName = format ["_USER_DEFINED #0/%1/%2", (_StartIndex + _foreachindex), (_x select 0)];
		private _MarkerObj = createMarker [_MarkerName, (_x select 2)];
		_MarkerObj setMarkerText (_x select 1);
		_MarkerObj setMarkerDir (_x select 3);
		_MarkerObj setMarkerSize (_x select 4);
		_MarkerObj setMarkerType (_x select 5);
		_MarkerObj setMarkerShape (_x select 6);
		_MarkerObj setMarkerColor (_x select 7);
		_MarkerObj setMarkerAlpha (_x select 8);
	} forEach _Markers;
};*/

if ("INIDBI2" in STNE_server_Mods) then {
	private _Markers = ["read", ["Markers", "Markers", []]] call INIDBI_map;
	private _Polylines = ["read", ["Markers", "Polylines", []]] call INIDBI_map;
	{
		_x call BIS_fnc_stringToMarker;
	} forEach _Markers;
	{
		private _MarkerObj = createMarker [_x select 0, _x select 1],
		_MarkerObj setMarkerColor (_x select 2);
		_MarkerObj setMarkerShape "POLYLINE";
		_MarkerObj setMarkerPolyline (_x select 3);
	} forEach _Polylines;
};