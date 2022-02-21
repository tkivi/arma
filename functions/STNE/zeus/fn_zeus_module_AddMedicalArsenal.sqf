// ZEUS MODULE: DCSARMA - Add Medical Arsenal
if ("ACE" in STNE_server_Mods) then {
	["DCSARMA", "Add Medical Arsenal",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				[_selected_object] call STNE_fnc_arsenal_addMedical;
			};
		}
	] call zen_custom_modules_fnc_register;
};