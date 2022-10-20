// ZEUS MODULE: DCSARMA - Server Settings
["DCSARMA Tools", "Change Server Settings",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];
		[
			"SERVER",
			[
				[
					"SLIDER",
					"ViewDistance",
					[
						0,
						12000,
						STNE_server_ViewDistance,
						0,
						nil,
						nil
					],
					true
				],
				[
					"CHECKBOX",
					"Enable Dynamic Simulation",
					[
						dynamicSimulationSystemEnabled
					],
					true
				],
				[
					"SLIDER",
					" - Characters",
					[
						50,
						5000,
						dynamicSimulationDistance "Group",
						0,
						nil,
						nil
					],
					true
				],
				[
					"SLIDER",
					" - Manned Vehicles",
					[
						50,
						5000,
						dynamicSimulationDistance "Vehicle",
						0,
						nil,
						nil
					],
					true
				],
				[
					"SLIDER",
					" - Props",
					[
						50,
						5000,
						dynamicSimulationDistance "Prop",
						0,
						nil,
						nil
					],
					true
				],
				[
					"SLIDER",
					" - Empty Vehicles",
					[
						50,
						5000,
						dynamicSimulationDistance "EmptyVehicle",
						0,
						nil,
						nil
					],
					true
				],
				[
					"SLIDER",
					" - Is Moving Modifier",
					[
						1,
						5,
						dynamicSimulationDistanceCoef "IsMoving",
						0,
						nil,
						nil
					],
					true
				]
			],
			{
				[((_this select 0) select 0)] call STNE_fnc_server_setViewDistance;
				[
					((_this select 0) select 1),
					((_this select 0) select 2),
					((_this select 0) select 3),
					((_this select 0) select 4),
					((_this select 0) select 5),
					((_this select 0) select 6)
				] call STNE_fnc_server_setDynamicSimulation;
			},
			{},
			[]
		] call zen_dialog_fnc_create;
	},
	STNE_icon_List
] call zen_custom_modules_fnc_register;