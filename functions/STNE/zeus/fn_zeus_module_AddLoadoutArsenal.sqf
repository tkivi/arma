// ZEUS MODULE: DCSARMA - Add Loadout Arsenal
if ((count (missionNamespace getVariable ["STNE_arsenal_Loadouts", [[],[]]] select 0)) > 0) then {
	["DCSARMA Arsenal", "Add Loadout Arsenal",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				[_selected_object] remoteExec ["STNE_fnc_arsenal_addLoadouts", _selected_object];
			};
		},
		STNE_icon_Arsenal
	] call zen_custom_modules_fnc_register;
};