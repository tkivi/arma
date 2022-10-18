// ZEUS MODULE: DCSARMA - Add SOG Arsenal
if ("WS" in STNE_server_Mods) then {
	["DCSARMA Arsenal", "Add WS Arsenal",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				[_selected_object] call STNE_fnc_arsenal_addWS;
			};
		}
	] call zen_custom_modules_fnc_register;
};