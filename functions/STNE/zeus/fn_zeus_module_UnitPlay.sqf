// ZEUS MODULE: DCSARMA - UnitPlay
if ((count (missionNamespace getVariable ["STNE_unitplay_Routes", []])) > 0) then {
	["DCSARMA Tools", "Select UnitPlay Route",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an unit"] call zen_common_fnc_showMessage;
			} else {
				private _OldParams = _selected_object getVariable ["STNE_unitplay_Params", []];
				private _Header = "NEW ROUTE";
				if (count (_OldParams) > 0) then {
					_Header = format ["CURRENT ROUTE: %1", _OldParams select 1];
				};
				private _HeaderText = _Header + " (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")";
				private _RouteNames = STNE_unitplay_Routes apply {_x select 0};
				[
					_HeaderText,
					[
						[
							"CHECKBOX",
							"Move unit to route start location",
							[
								false
							],
							false
						],
						[
							"COMBO",
							"Route",
							[
								_RouteNames,
								_RouteNames,
								if (count (_OldParams) > 0) then {_RouteNames find (_OldParams select 1)} else {0}
							],
							false
						],
						[
							"CHECKBOX",
							"Shutdown engine",
							[
								if (count (_OldParams) > 0) then {_OldParams select 2} else {false}
							],
							false
						],
						[
							"CHECKBOX",
							"Reset to route start location",
							[
								if (count (_OldParams) > 0) then {_OldParams select 3} else {false}
							],
							false
						],
						[
							"CHECKBOX",
							"Unload cargo on ground",
							[
								if (count (_OldParams) > 0) then {_OldParams select 4} else {false}
							],
							false
						]
					],
					{
						private _Object = (_this select 1) select 0;
						private _MoveToStart = (_this select 0) select 0;
						private _RouteName = (_this select 0) select 1;
						private _EngineOff = (_this select 0) select 2;
						private _ResetLocation = (_this select 0) select 3;
						private _UnloadCargo = (_this select 0) select 4;
						_Object setVariable ["STNE_unitplay_Params", [_Object, _RouteName, _EngineOff, _ResetLocation, _UnloadCargo], true];
						if (_MoveToStart) then {
							[_Object, _RouteName, _EngineOff, _ResetLocation, _UnloadCargo, _MoveToStart] remoteExec ["STNE_fnc_server_runUnitPlay", _Object];
						};
					},
					{},
					[_selected_object]
				] call zen_dialog_fnc_create;
			};
		},
		STNE_icon_Route
	] call zen_custom_modules_fnc_register;
};