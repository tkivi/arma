// ZEUS MODULE: DCSARMA - Trace Bullets
["DCSARMA Diagnostic", "Trace Bullets",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];
		if (_selected_object isEqualTo objNull) then {
			if ((missionNamespace getVariable ["BIS_tracedShooter", objNull]) isEqualTo objNull) then {
				["Place on an unit"] call zen_common_fnc_showMessage;
			} else {
				["Trace Bullets disabled"] call zen_common_fnc_showMessage;
				missionNamespace setVariable ["BIS_tracedShooter", nil, true];
			};
		} else {
			["Trace Bullets enabled"] call zen_common_fnc_showMessage;
			missionNamespace setVariable ["BIS_tracedShooter", nil, true];
			_selected_object remoteExec ["BIS_fnc_traceBullets", 0];
		};
	},
	STNE_icon_Tracers
] call zen_custom_modules_fnc_register;