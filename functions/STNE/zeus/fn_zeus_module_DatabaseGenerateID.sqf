// ZEUS MODULE: DCSARMA - Generate ID
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		["DCSARMA Database", "Generate ID",
			{
				private _module_position = param [0, [0,0,0], [[]]];
				private _selected_object = param [1, ObjNull, [ObjNull]];
				if (_selected_object isEqualTo objNull) then {
					["Place on an object"] call zen_common_fnc_showMessage;
				} else {
					private _ID = [_selected_object] call STNE_fnc_database_generateID;
					if !(_ID isEqualTo "") then {
						[format ["Generated ID: %1", _ID]] call zen_common_fnc_showMessage;
					};
				};
			}
		] call zen_custom_modules_fnc_register;
	};
};