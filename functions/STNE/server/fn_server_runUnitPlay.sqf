/*
 * Run UnitPlay route (SP/MP).
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Route name <STRING>
 * 2: Shutdown engine <BOOLEAN>
 * 3: Reset to start location <BOOLEAN>
 * 4: Unload cargo on ground <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object, "route1", true, true] call STNE_fnc_server_runUnitPlay;
 *
 */

private _Object = param [0, objNull, [objNull]];
private _RouteName = param [1, "", [""]];
private _EngineOff = param [2, false, [false]];
private _ResetLocation = param [3, false, [false]];
private _UnloadCargo = param [4, false, [false]];
private _MoveToStart = param [5, false, [false]];

// Exit if object is null or route name is empty
if ((_Object isEqualTo ObjNull) || (_RouteName isEqualTo "")) exitWith {};

// Exit if object is not local
if !(local _Object) exitWith {};

// Get selected route data
private _RouteData = [];
{
	if ((_x select 0) isEqualTo _RouteName) exitWith {
		_RouteData = _x select 1;
	};
} forEach STNE_unitplay_Routes;

// Route data found, playback
if !(_RouteData isEqualTo []) then {
	if (_Object getVariable ["STNE_unitplay_Done", true]) then {
		_Object setVariable ["STNE_unitplay_Done", false];
		if (_MoveToStart) then {	// Move to start location and terminate unitplay
			[_Object, _RouteData, [_Object, "STNE_unitplay_Done"]] spawn BIS_fnc_unitPlay;
			sleep 1;
			private _StartVectorDir = vectorDir _Object;
			private _StartVectorUp = vectorUp _Object;
			private _StartPosWorld = getPosWorld _Object;
			_Object setVariable ["BIS_fnc_unitPlay_terminate", true];
			_Object setVectorDirAndUp [_StartVectorDir, _StartVectorUp];
			_Object setPosWorld _StartPosWorld;
		} else {
			_Object engineOn true;
			[_Object, _RouteData, [_Object, "STNE_unitplay_Done"]] spawn BIS_fnc_unitPlay;
			// Unload cargo units when on ground
			if (_UnloadCargo) then {
				[_Object] spawn {
					private _Object = param [0, objNull, [objNull]];
					waitUntil {sleep 1; ((getPosATL _Object) select 2) > 3};
					waitUntil {sleep 1; (speed _Object) < 1; ((getPosATL _Object) select 2) < 1};
					if (alive _Object) then {
						{
							sleep 0.5;
							if (alive _x && !(isPlayer _x)) then {
								moveOut _x;
								unassignVehicle _x;
							};
						} forEach ((crew _Object) select {(assignedVehicleRole _x) select 0 isEqualTo "cargo"});
					};
				};
			};
			// Try to lower landing gear when landing
			if (_Object isKindOf "Air") then {
				[_Object] spawn {
					private _Object = param [0, objNull, [objNull]];
					while {sleep 1; alive _Object; !(_Object getVariable ["STNE_unitplay_Done", false])} do {
						if (((getPosATL _Object) select 2) < 10) then {
							_Object action ["LandGear", _Object];
						};
					};
				};
			};
			// Route completed
			[_Object, _RouteData, _EngineOff, _ResetLocation] spawn {
				private _Object = param [0, objNull, [objNull]];
				private _RouteData = param [1, [], [[]]];
				private _EngineOff = param [2, false, [false]];
				private _ResetLocation = param [3, false, [false]];
				// Get start location
				sleep 1;
				private _StartVectorDir = vectorDir _Object;
				private _StartVectorUp = vectorUp _Object;
				private _StartPosWorld = getPosWorld _Object;
				// Wait until route done
				waitUntil {sleep 1; _Object getVariable ["STNE_unitplay_Done", false]};
				if (alive _Object) then {
					// Engine off
					if (_EngineOff) then {
						_Object engineOn false;
					};
					// Reset location
					if (_ResetLocation) then {
						_Object setVectorDirAndUp [_StartVectorDir, _StartVectorUp];
						_Object setPosWorld _StartPosWorld;
					};
				};
			};
		};
	};
};