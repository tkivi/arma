// ZEUS MODULE: DCSARMA - UnitPlay
if ((count (missionNamespace getVariable ["STNE_unitplay_Data", []])) > 0) then {
	["DCSARMA Tools", "Run UnitPlay Track",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an unit"] call zen_common_fnc_showMessage;
			} else {
				private _header = "UNITPLAY (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")";
				private _TrackName = STNE_unitplay_Data apply {_x select 0};
				[
					_header,
					[
						[
							"COMBO",
							"Track",
							[
								_TrackName,
								_TrackName,
								1
							],
							false
						],
						[
							"CHECKBOX",
							"Shutdown engine",
							[
								false
							],
							false
						],
						[
							"CHECKBOX",
							"Reset location",
							[
								false
							],
							false
						],
						[
							"CHECKBOX",
							"Unload cargo on ground",
							[
								false
							],
							false
						]
					],
					{
						private _Object = (_this select 1) select 0;
						private _TrackName = (_this select 0) select 0;
						private _EngineOff = (_this select 0) select 1;
						private _ResetLocation = (_this select 0) select 2;
						private _UnloadCargo = (_this select 0) select 3;
						[_Object, _TrackName, _EngineOff, _ResetLocation, _UnloadCargo] remoteExec ["STNE_fnc_server_runUnitPlay", _Object];
					},
					{},
					[_selected_object]
				] call zen_dialog_fnc_create;
			};
		},
		STNE_icon_Play
	] call zen_custom_modules_fnc_register;
};