// ZEUS MODULE: DCSARMA - Play Music
if ((count ("true" configClasses (missionConfigFile >> "CfgMusic") apply {configName _x})) > 0) then {
	["DCSARMA Audio", "Play Music",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];

			private _configtable = [""];
			private _confignames = [""];
			private _musictable = ("true" configClasses (missionConfigFile >> "CfgMusic") apply {configName _x});
			_configtable append _musictable;
			{
				_confignames pushBack (getText (missionconfigFile >> "CfgMusic" >> _x >> "name"));
			} forEach _musictable;
			[
				"PLAY MUSIC",
				[
					[
						"COMBO",
						"Music",
						[
							_configtable,
							_confignames,
							0
						],
						true
					]
				],
				{
					[((_this select 0) select 0)] remoteExec ["playMusic", 0];
				},
				{},
				[]
			] call zen_dialog_fnc_create;
		},
		STNE_icon_Music
	] call zen_custom_modules_fnc_register;
};