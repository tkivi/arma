// ZEUS MODULE: DCSARMA - Add Location/Mobile Respawn
["DCSARMA Tools", "Add Location/Mobile Respawn",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];

		private _header = "ADD RESPAWN TO LOCATION (" + ((_module_position call BIS_fnc_position) call BIS_fnc_locationDescription) + ")";
		if !(isNull _selected_object) then {
			_header = "ADD MOBILE RESPAWN TO OBJECT (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")";
		};

		[
			_header,
			[
				[
					"SIDES",
					"Side",
					WEST,
					false
				]
			],
			{
				if (isNull ((_this select 1) select 1)) then {
					[((_this select 0) select 0), [(((_this select 1) select 0) select 0), (((_this select 1) select 0) select 1), 0], nil] call BIS_fnc_addRespawnPosition;
				} else {
					[((_this select 0) select 0), ((_this select 1) select 1), (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName"))] call BIS_fnc_addRespawnPosition;
				};
			},
			{},
			[_module_position, _selected_object]
		] call zen_dialog_fnc_create;
	},
	STNE_icon_Respawn
] call zen_custom_modules_fnc_register;