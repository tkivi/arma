/*
 * Add/Initialize CBA events.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_event_addEvents;
 *
 */

["STNE_event_addSatelliteTV", {[_this] call STNE_fnc_action_addSatelliteTV}] call CBA_fnc_addEventHandler;
["STNE_event_addSpectator", {[_this] call STNE_fnc_action_addSpectator}] call CBA_fnc_addEventHandler;
["STNE_event_addLoadouts", {[_this] call STNE_fnc_action_addLoadouts}] call CBA_fnc_addEventHandler;

// AddAction for loading Vehicle in Vehicle cargo
if (missionNamespace getVariable ["STNE_logistic_ViV", false]) then {
	["All", "InitPost", {
		private _Object = param [0, ObjNull, [ObjNull]];
		if !(isNull _Object) then {
			private _ObjectName = getText (configFile >> "CfgVehicles" >> typeOf _Object >> "displayName");
			_Object addAction
			[
				format ["Load %1 in nearest vehicle", _ObjectName],
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					private _NearestObjects = nearestObjects [_target, ["Car", "Tank", "Ship", "Air"], 7, true];
					private _Message = format ["No suitable vehicle found near %1", _arguments];
					{
						if ((_x canVehicleCargo _target) select 0) exitwith {
							private _Success = _x setVehicleCargo _target;
							if (_Success) then {
								private _CarrierName = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
								_Message = format ["%1 loaded in %2", _arguments, _CarrierName];
							};
						};
					} forEach _NearestObjects;
					systemChat _Message;
				},
				_ObjectName,		// arguments
				1.5,                // priority
				false,              // showWindow
				true,               // hideOnUse
				"",                 // shortcut
				"alive _target && player == vehicle player && driver _target == _target && (((nearestObjects [_target, ['Car','Tank','Ship','Air'], 7, true]) select 0) canVehicleCargo _target) select 0",	// condition
				2,                  // radius
				false,              // unconscious
				"",                 // selection
				""                  // memoryPoint
			];
		};
	}, nil, ["Man", "WeaponHolder"], true] call CBA_fnc_addClassEventHandler;
};

// Override loadout with custom loadout
if (count (missionNamespace getVariable ["STNE_init_Loadouts", []]) > 0) then {
	{
		missionNamespace setVariable ["STNE_init_Loadouts_" + (_x select 0), (_x select 1), true];
		// InitPost
		[(_x select 0), "InitPost", {
			private _Object = param [0, ObjNull, [ObjNull]];
			if !(isNull _Object) then {
				[_Object] call STNE_fnc_init_setLoadout;
			};
		}, nil, [], true] call CBA_fnc_addClassEventHandler;
		// Respawn
		[(_x select 0), "Respawn", {
			private _Object = param [0, ObjNull, [ObjNull]];
			if !(isNull _Object) then {
				[_Object] call STNE_fnc_init_setLoadout;
			};
		}, nil, [], true] call CBA_fnc_addClassEventHandler;
	} forEach STNE_init_Loadouts;
};

// ACE extended actions
if (missionNamespace getVariable ["STNE_ace_Actions", false]) then {
	["ACE_bodyBagObject", "InitPost", {
		private _Object = param [0, ObjNull, [ObjNull]];
		if !(isNull _Object) then {
			[_Object, true, [0, 0.7, 0.9], 90] call ace_dragging_fnc_setCarryable;
		};
	}, nil, ["Man", "WeaponHolder"], true] call CBA_fnc_addClassEventHandler;
};