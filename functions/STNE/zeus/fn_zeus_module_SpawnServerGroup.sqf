// ZEUS MODULE: DCSARMA - Spawn Server Group
["DCSARMA Spawn", "Spawn Server Group",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];

		if (isNil "STNE_spawner") then {STNE_spawner = [];};
		STNE_spawner set [0, _module_position];
		STNE_spawner_dialog = {
			private _ConfigArray = [];
			private _NameArray = [];
			private _ToolTip = "";
			switch (count STNE_spawner) do {
				case 1: {
					_ToolTip = "Side";
					_ConfigArray = "true" configClasses (configFile >> "CfgGroups") apply {configName _x};
					{_NameArray pushBack (getText (configFile >> "CfgGroups" >> _x >> "Name"));} forEach _ConfigArray;
				};
				case 2: {
					_ToolTip = "Faction (" + (STNE_spawner select 1) + ")";
					_ConfigArray = "true" configClasses (configFile >> "CfgGroups" >> (STNE_spawner select 1)) apply {configName _x};
					{_NameArray pushBack (getText (configFile >> "CfgGroups" >> (STNE_spawner select 1) >> _x >> "Name"));} forEach _ConfigArray;
				};
				case 3: {
					_ToolTip = "Type (" + (STNE_spawner select 1) + ")";
					_ConfigArray = "true" configClasses (configFile >> "CfgGroups" >> (STNE_spawner select 1) >> (STNE_spawner select 2)) apply {configName _x};
					{_NameArray pushBack (getText (configFile >> "CfgGroups" >> (STNE_spawner select 1) >> (STNE_spawner select 2) >> _x >> "Name"));} forEach _ConfigArray;
				};
				case 4: {
					_ToolTip = "Group (" + (STNE_spawner select 1) + ")";
					_ConfigArray = "true" configClasses (configFile >> "CfgGroups" >> (STNE_spawner select 1) >> (STNE_spawner select 2) >> (STNE_spawner select 3)) apply {configName _x};
					{_NameArray pushBack (getText (configFile >> "CfgGroups" >> (STNE_spawner select 1) >> (STNE_spawner select 2) >> (STNE_spawner select 3) >> _x >> "Name"));} forEach _ConfigArray;
				};
				case 5: {
					[[STNE_spawner select 0, STNE_spawner select 1, STNE_spawner select 2, STNE_spawner select 3, STNE_spawner select 4]] remoteExec ["STNE_fnc_server_addGroup", 2];
					STNE_spawner resize 4;
				};
				default {
					_ToolTip = "Side";
					_ConfigArray = "true" configClasses (configFile >> "CfgGroups") apply {configName _x};
					{_NameArray pushBack (getText (configFile >> "CfgGroups" >> _x >> "Name"));} forEach _ConfigArray;
				};
			};
			[
				"SPAWN SERVER GROUP",
				[
					[
						"COMBO",
						_ToolTip,
						[
							_ConfigArray,
							_NameArray,
							0
						],
						false
					]
				],
				{STNE_spawner pushBackUnique ((_this select 0) select 0); [] call STNE_spawner_dialog},
				{STNE_spawner = nil},
				[]
			] call zen_dialog_fnc_create;
		};
		[] call STNE_spawner_dialog;
	}
] call zen_custom_modules_fnc_register;