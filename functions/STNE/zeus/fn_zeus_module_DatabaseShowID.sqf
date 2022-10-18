// ZEUS MODULE: DCSARMA - Toggle show ID
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		["DCSARMA Database", "Toggle show ID",
			{
				private _Return = [] call STNE_fnc_database_showID;
				if (_Return) then {
					["Show database ID"] call zen_common_fnc_showMessage;
				} else {
					["Hide database ID"] call zen_common_fnc_showMessage;
				};
			}
		] call zen_custom_modules_fnc_register;
	};
};