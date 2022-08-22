// ZEUS MODULE: DCSARMA - Play Sound
if ((count ("true" configClasses (missionConfigFile >> "CfgSounds") apply {configName _x})) > 0) then {
	["DCSARMA", "Play Sound 3D",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];

			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				private _confignames = [];
				private _configtable = ("true" configClasses (missionConfigFile >> "CfgSounds") apply {configName _x});
				{
					_confignames pushBack (getText (missionconfigFile >> "CfgSounds" >> _x >> "name"));
				} forEach _configtable;
				[
					"PLAY 3D SOUND FROM OBJECT (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")",
					[
						[
							"COMBO",
							"Sound",
							[
								_configtable,
								_confignames,
								0
							],
							true
						]
					],
					{
						[((_this select 1) select 1), ((_this select 0) select 0)] remoteExec ["say3D", 0];
					},
					{},
					[_module_position, _selected_object]
				] call zen_dialog_fnc_create;
			};
		}
	] call zen_custom_modules_fnc_register;
};