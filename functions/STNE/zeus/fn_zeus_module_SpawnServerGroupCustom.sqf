// ZEUS MODULE: DCSARMA - Spawn Server Group Custom
if (count (missionNamespace getVariable ["STNE_server_CustomGroups", []]) > 0) then {
	["DCSARMA Spawn", "Spawn Server Group Custom",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];

			if (isNil "STNE_spawner_Custom") then {STNE_spawner_Custom = [];};
			STNE_spawner_Custom set [0, _module_position];
			[
				"SPAWN SERVER GROUP CUSTOM",
				[
					[
						"SIDES",
						"Side",
						WEST,
						false
					],
					[
						"COMBO",
						"Group",
						[
							STNE_server_CustomGroups apply {_x select 1},
							STNE_server_CustomGroups apply {_x select 0},
							0
						],
						false
					]
				],
				{[(STNE_spawner_Custom select 0), ((_this select 0) select 0), ((_this select 0) select 1)] remoteExec ["STNE_fnc_server_addGroupCustom", 2]},
				{},
				[]
			] call zen_dialog_fnc_create;
		}
	] call zen_custom_modules_fnc_register;
};