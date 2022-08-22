// ZEUS MODULE: DCSARMA - Add unit damage
if ("ACE" in STNE_server_Mods) then {
	["DCSARMA", "Add Unit Damage",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull || !(_selected_object isKindOf "Man")) then {
				["Place on an unit"] call zen_common_fnc_showMessage;
			} else {
				private _header = "ADD UNIT DAMAGE (" + (getText (configFile >> "CfgVehicles" >> typeOf _selected_object >> "displayName")) + ")";
				private _dmgtypes = "true" configClasses (configFile >> "ACE_Medical_Injuries" >> "damageTypes") apply {configName _x};
				[
					_header,
					[
						[
							"COMBO",
							"DamageType",
							[
								_dmgtypes,
								_dmgtypes,
								1
							],
							false
						],
						[
							"SLIDER",
							"Head",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						],
						[
							"SLIDER",
							"Body",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						],
						[
							"SLIDER",
							"LeftArm",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						],
						[
							"SLIDER",
							"RightArm",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						],
						[
							"SLIDER",
							"LeftLeg",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						],
						[
							"SLIDER",
							"RightLeg",
							[
								0,
								1,
								0,
								2,
								nil,
								nil
							],
							true
						]
					],
					{
						private _bodyparts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
						private _unit = ((_this select 1) select 0);
						private _dmgarray = _this select 0;
						private _type = _dmgarray deleteAt 0;
						{
							private _damage = _dmgarray select _forEachIndex;
							if (_damage > 0) then {
								[_unit, _damage, _x, _type] call ace_medical_fnc_addDamageToUnit;
								//systemChat format ["part: %1, index: %2, type: %3, damage: %3", _x, _forEachIndex, _type, _damage];
							};
						} forEach _bodyparts;
					},
					{},
					[_selected_object]
				] call zen_dialog_fnc_create;
			};
		}
	] call zen_custom_modules_fnc_register;
};