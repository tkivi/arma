/*
 * Run UnitPlay track (SP/MP).
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Track name <STRING>
 * 2: Shutdown engine <BOOLEAN>
 * 3: Reset to start location <BOOLEAN>
 * 4: Unload cargo on ground <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object, "track1", true, true] call STNE_fnc_server_runUnitPlay;
 *
 */

private _Object = param [0, objNull, [objNull]];
private _TrackName = param [1, "", [""]];
private _EngineOff = param [2, false, [false]];
private _ResetLocation = param [3, false, [false]];
private _UnloadCargo = param [4, false, [false]];

// Exit if object is null or track name is empty
if ((_Object isEqualTo ObjNull) || (_TrackName isEqualTo "")) exitWith {};

// Exit if object is not local
if !(local _Object) exitWith {};

// Get selected track data
private _TrackData = [];
{
	if ((_x select 0) isEqualTo _TrackName) exitWith {
		_TrackData = _x select 1;
	};
} forEach STNE_unitplay_Data;

// Track data found, playback
if !(_TrackData isEqualTo []) then {
	_Object setVariable ["STNE_unitplay_Done", false];
	_Object engineOn true;
	[_Object, _TrackData, [_Object, "STNE_unitplay_Done"]] spawn BIS_fnc_unitPlay;
	// Unload cargo units when on ground
	if (_UnloadCargo) then {
		[_Object] spawn {
			private _Object = param [0, objNull, [objNull]];
			if (_Object isEqualTo ObjNull) exitWith {};
			waitUntil {sleep 1; ((getPosATL _Object) select 2) > 3};
			waitUntil {sleep 1; (speed _Object) < 1; ((getPosATL _Object) select 2) < 1};
			{
				if !(isPlayer _x) then {
					moveOut _x;
					unassignVehicle _x;
				};
				sleep 0.5;
			} forEach ((crew _Object) select {(assignedVehicleRole _x) select 0 isEqualTo "cargo"});
		};
	};
	// Track completed
	[_Object, _TrackData, _EngineOff, _ResetLocation] spawn {
		private _Object = param [0, objNull, [objNull]];
		private _TrackData = param [1, [], [[]]];
		private _EngineOff = param [2, false, [false]];
		private _ResetLocation = param [3, false, [false]];
		// Exit if objNull or track empty
		if ((_Object isEqualTo ObjNull) || (_TrackData isEqualTo [])) exitWith {};
		// Get start location
		sleep 1;
		private _StartVectorDir = vectorDir _Object;
		private _StartVectorUp = vectorUp _Object;
		private _StartPosWorld = getPosWorld _Object;
		// Wait until track done
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