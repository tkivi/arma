// ZEUS MODULE: DCSARMA - UnitPlay record
if ((isMultiplayer && isServer) || !(isMultiplayer)) then {
	["DCSARMA Tools", "Record UnitPlay Track",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an unit"] call zen_common_fnc_showMessage;
			} else {
				if !(local _selected_object) then {
					["Unit must be local to you"] call zen_common_fnc_showMessage;
				} else {
					private _header = "RECORD UNITPLAY (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")";
					[
						_header,
						[
							[
								"SLIDER",
								"Track max duration, seconds",
								[
									1,
									900,
									300,
									0,
									nil,
									nil
								],
								false
							],
							[
								"SLIDER",
								"Frames per second",
								[
									1,
									100,
									20,
									0,
									nil,
									nil
								],
								false
							]
						],
						{
							private _Object = (_this select 1) select 0;
							private _MaxDuration = (_this select 0) select 0;
							private _FPS = (_this select 0) select 1;
							[_Object, _MaxDuration, _FPS, false] spawn BIS_fnc_UnitCapture;
						},
						{},
						[_selected_object]
					] call zen_dialog_fnc_create;
				};
			};
		},
		STNE_icon_Save
	] call zen_custom_modules_fnc_register;
};