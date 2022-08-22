/*
 * Make AI group to charge to target unit.
 *
 * Arguments:
 * 0: AI unit <OBJECT>
 * 1: Target unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit1, unit2] spawn STNE_fnc_ai_charge;
 *
 */

private _ai_unit = param [0, ObjNull, [ObjNull]];
private _target_unit = param [1, ObjNull, [ObjNull]];

if (!(_ai_unit isEqualTo objNull) && !(_target_unit isEqualTo objNull)) then {
	// Get group and delete waypoints
	private _group = group _ai_unit;
	[_group, (currentWaypoint _group)] setWaypointPosition [getPosASL ((units _group) select 0), -1];
	sleep 0.1;
	for "_i" from count waypoints _group - 1 to 0 step -1 do
	{
		deleteWaypoint [_group, _i];
	};
	// Toggle charge
	{
		private _oldValues = _x getVariable ["STNE_ai_charge", []];
		if (_oldValues isEqualTypeArray ["","","",0,0,0,0]) then {
			// Return to old behaviour
			_x setUnitPos (_oldValues select 0);
			_x setSpeedMode (_oldValues select 1);
			_x setbehaviour (_oldValues select 2);
			_x setskill ["spotDistance", (_oldValues select 3)];
			_x setskill ["spotTime", (_oldValues select 4)];
			_x setskill ["courage", (_oldValues select 5)];
			_x setskill ["commanding", (_oldValues select 6)];
			_x forceSpeed -1;
			_x enableAI "AUTOCOMBAT";
			_x setVariable ["STNE_ai_charge", nil];
			doStop _x;
			_x doFollow (leader _group);
		} else {
			// Get random position
			private _center = getPosATL _target_unit;
			private _radius = 15;
			private _angle = random 360;
			private _randomSquareRoot = sqrt random 1;
			private _distance = _radius * _randomSquareRoot;
			private _position = _center getPos [_distance, _angle];
			// Get current values
			private _oldUnitPos = unitPos _x;
			private _oldSpeedMode = speedMode (group _x);
			private _oldBehaviour = behaviour _x;
			private _oldSpotDistance = _x skill "spotDistance";
			private _oldSpotTime = _x skill "spotTime";
			private _oldCourage = _x skill "courage";
			private _oldCommanding = _x skill "commanding";
			_x setVariable ["STNE_ai_charge", [_oldUnitPos, _oldSpeedMode, _oldBehaviour, _oldSpotDistance, _oldSpotTime, _oldCourage, _oldCommanding]];
			// Charge
			_x doMove _position;
			_x setUnitPos "UP";
			_x setSpeedMode "FULL";
			_x setbehaviour "SAFE";
			_x setskill ["spotDistance", 0.1];
			_x setskill ["spotTime", 0.1];
			_x setskill ["courage", 1];
			_x setskill ["commanding", 0.1];
			_x forceSpeed (_x getSpeed "NORMAL");
			_x disableAI "AUTOCOMBAT";
		};
	} forEach (units _group);
};