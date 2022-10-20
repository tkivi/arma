// ZEUS MODULE: DCSARMA - AI Charge
["DCSARMA Unit", "AI Charge",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];
		if (_selected_object isEqualTo objNull || !(_selected_object isKindOf "Man") || isPlayer _selected_object) then {
			["Place on an AI unit"] call zen_common_fnc_showMessage;
		} else {
			private _nearestUnit = objNull;
			private _nearestDist = viewDistance;
			{
				if (!(_x isEqualTo _selected_object) && (side _x != side _selected_object)) then {
					private _unitDist = _selected_object distance _x;
					if (_unitDist < _nearestDist) then {
						_nearestDist = _unitDist;
						_nearestUnit = _x;
					};
				};
			} forEach allPlayers; //playableUnits;
			if (_nearestUnit isEqualTo objNull) then {
				[format ["No player found in %1 meters", _nearestDist]] call zen_common_fnc_showMessage;
			} else {
				[format ["%1 charging to %2", (group _selected_object), _nearestUnit]] call zen_common_fnc_showMessage;
				//{
					//_x doMove (getPosATL _nearestUnit);
					//_x setUnitPos "UP";
					//_x setSpeedMode "FULL";
					//_x setbehaviour "SAFE";
					//_x setskill ["spotDistance", 0.1];
					//_x setskill ["spotTime", 0.1];
					//_x setskill ["courage", 1];
					//_x setskill ["commanding", 0.1];
					//_x forceSpeed (_x getSpeed "NORMAL");
					//_x disableAI "AUTOCOMBAT";
					//waitUntil {moveToCompleted _unit};
					[_selected_object, _nearestUnit] spawn STNE_fnc_ai_charge;
				//} forEach units (group _selected_object);
			};
		};
	},
	STNE_icon_Run
] call zen_custom_modules_fnc_register;