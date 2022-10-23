/*
 * Save all player created map markers.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_database_saveMarkers;
 *
 */

private _Markers = [];
private _Polylines = [];

/*{
	private _Split = (_x splitString " ,/,#");
	if (((_Split select 0) isEqualTo "_USER_DEFINED") && !((markerShape _x) isEqualTo "POLYLINE")) then {
		if ((_Split select 3) isEqualTo "0") then {
			private _Marker = [
				_Split select 3,
				markerText _x,
				markerPos _x,
				markerDir _x,
				markerSize _x,
				markerType _x,
				markerShape _x,
				markerColor _x,
				markerAlpha _x
			];
			_Markers pushBack _Marker;
		};
	};
} forEach allMapMarkers;*/

{
	if ((markerShape _x) isEqualTo "POLYLINE") then {
		_Polylines pushBack [_x, markerPos _x, markerColor _x, markerPolyline _x];
	} else {
		_Markers pushBack ([_x, ":"] call BIS_fnc_markerToString);
	};
} forEach (allMapMarkers select {"_USER_DEFINED" in _x});

if ("INIDBI2" in STNE_server_Mods) then {
	["write", ["Markers", "Markers", _Markers]] call INIDBI_map;
	["write", ["Markers", "Polylines", _Polylines]] call INIDBI_map;
};