// ZEUS MODULE: DCSARMA - Add Spectator
if ("ACE" in STNE_server_Mods) then {
	["DCSARMA Tools", "Add Spectator",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				["STNE_event_addSpectator", _selected_object] call CBA_fnc_globalEventJIP;
			};
		}
	] call zen_custom_modules_fnc_register;
};