// ZEUS MODULE: DCSARMA - Manual Save
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		["DCSARMA Database", "Manual Save",
			{
				[] remoteExec ["STNE_fnc_database_writeDatabase", 2];
				["Manual Save"] call zen_common_fnc_showMessage;
			}
		] call zen_custom_modules_fnc_register;
	};
};