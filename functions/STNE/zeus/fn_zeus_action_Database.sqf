// Database
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		// Main menu, Database
		private _ActionDatabase = [
			"STNE_Database",
			"Database",
			STNE_icon_Save,
			{},
			{true}
		] call zen_context_menu_fnc_createAction;
		[_ActionDatabase, [], 0] call zen_context_menu_fnc_addAction;
		// Toggle show ID
		private _ActionToggleShowID = [
			"STNE_ShowID",
			"Toggle show ID",
			STNE_icon_Toggle,
			{
				private _Toggle = [] call STNE_fnc_database_showID;
				if (_Toggle) then {
					["Show database ID"] call zen_common_fnc_showMessage;
				} else {
					["Hide database ID"] call zen_common_fnc_showMessage;
				};
			},
			{((_this select 1) isEqualTo [])}
		] call zen_context_menu_fnc_createAction;
		[_ActionToggleShowID, ["STNE_Database"], 0] call zen_context_menu_fnc_addAction;
		// Generate ID
		private _ActionGenerateID = [
			"STNE_GenerateID",
			"Generate ID",
			STNE_icon_Add,
			{
				{
					[_x] call STNE_fnc_database_generateID;
				} forEach (_this select 1);
				[format ["Generate ID: %1 objects selected", (count (_this select 1))]] call zen_common_fnc_showMessage;
			},
			{!((_this select 1) isEqualTo [])}
		] call zen_context_menu_fnc_createAction;
		[_ActionGenerateID, ["STNE_Database"], 0] call zen_context_menu_fnc_addAction;
		// Remove ID
		private _ActionRemoveID = [
			"STNE_RemoveID",
			"Remove ID",
			STNE_icon_Remove,
			{
				{
					[_x] call STNE_fnc_database_removeID;
				} forEach (_this select 1);
				[format ["Remove ID: %1 objects selected", (count (_this select 1))]] call zen_common_fnc_showMessage;
			},
			{!((_this select 1) isEqualTo [])}
		] call zen_context_menu_fnc_createAction;
		[_ActionRemoveID, ["STNE_Database"], 0] call zen_context_menu_fnc_addAction;
	};
};