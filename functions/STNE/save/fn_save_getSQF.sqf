/*
 * Get SQF from objects.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[object1,object2,object3]] call STNE_fnc_save_getSQF;
 *
 */

params [["_object_array",[]]];
private _output_text = "";
private _output = [];
private _waypoints = [];
private _return = false;

// Exit if array is empty
if (_object_array isEqualTo []) exitWith
{
	_return;
};

// Define arrays
private _vehicles = [];
private _groups_vehicles = [];
private _groups = [];

// Split array to vehicles, groups etc..
{
	// Object must be object and not in database save
	if (((_x getVariable ["oldf_db_id",""]) isEqualTo "") && (_x isEqualType objNull)) then
	{
		if (_x isKindOf "CAManBase") then
		{
			if !((group _x) in _groups) then
			{
				_groups pushBack (group _x);
			};
		}
			else
		{
			if ((count (crew _x)) > 0) then
			{
				_groups pushBack (group _x);
			}
				else
			{
				_vehicles pushBack _x;
			};
		};
	};
} forEach _object_array;

// Process vehicle_empty array
{
	// Basic empty vehicle
	_output pushBack format
	[
		"_object = '%1' createVehicle [0,0,0]; _object setVectorDirAndUp [%3,%4]; _object setPosWorld %2; ",
		(typeOf _x),
		(getPosWorld _x),
		(vectorDir _x),
		(vectorUp _x)
	];
	// Vehicle customization
	private _customization = ([_x] call BIS_fnc_getVehicleCustomization);
	if !(_customization isEqualTo [[],[]]) then
	{
		_output pushBack format
		[
			"[_object, %1, %2] call BIS_fnc_initVehicle; ",
			str(_customization select 0),
			str(_customization select 1)
		];
	};
	// Vehicle lock
	if ((locked _x) >= 0) then
	{
		_output pushBack ("_object lock " + str(locked _x) + "; ");
	};
	// Cargo inventory
	private _vehicle_cargo = [_x] call STNE_fnc_save_getCargo;
	// Process weapon cargo
	_output pushBack "clearWeaponCargoGlobal _object; ";
	if !((_vehicle_cargo select 0) isEqualTo [[],[]]) then
	{
		_output pushBack format
		[
			"_object_cargo = %1; for '_i' from 0 to (count(_object_cargo select 0) - 1) do {_object addWeaponCargoGlobal [((_object_cargo select 0) select _i), ((_object_cargo select 1) select _i)];}; ",
			(_vehicle_cargo select 0)
		];
	};
	// Process magazine cargo
	_output pushBack "clearMagazineCargoGlobal _object; ";
	if !((_vehicle_cargo select 1) isEqualTo [[],[]]) then
	{
		_output pushBack format
		[
			"_object_cargo = %1; for '_i' from 0 to (count(_object_cargo select 0) - 1) do {_object addMagazineCargoGlobal [((_object_cargo select 0) select _i), ((_object_cargo select 1) select _i)];}; ",
			(_vehicle_cargo select 1)
		];
	};
	// Process item cargo
	_output pushBack "clearItemCargoGlobal _object; ";
	if !((_vehicle_cargo select 2) isEqualTo [[],[]]) then
	{
		_output pushBack format
		[
			"_object_cargo = %1; for '_i' from 0 to (count(_object_cargo select 0) - 1) do {_object addItemCargoGlobal [((_object_cargo select 0) select _i), ((_object_cargo select 1) select _i)];}; ",
			(_vehicle_cargo select 2)
		];
	};
	// Process backpack cargo
	_output pushBack "clearBackpackCargoGlobal _object; ";
	if !((_vehicle_cargo select 3) isEqualTo [[],[]]) then
	{
		_output pushBack format
		[
			"_object_cargo = %1; for '_i' from 0 to (count(_object_cargo select 0) - 1) do {_object addBackpackCargoGlobal [((_object_cargo select 0) select _i), ((_object_cargo select 1) select _i)];}; ",
			(_vehicle_cargo select 3)
		];
	};
	// Add vehicle as curator editable object
	//_output pushBack "[OLDF_Curator_Admin, [[_object], true]] remoteExec ['addCuratorEditableObjects', 2]; ";
	//_output pushBack "[OLDF_Curator_GM, [[_object], true]] remoteExec ['addCuratorEditableObjects', 2]; ";
	// Dynamic simulation
	_output pushBack format ["_object enableDynamicSimulation %1; ", (dynamicSimulationEnabled _x)];
} forEach _vehicles;

// Process groups array, no vehicles
{
	// Create new group if leader is not a player or profiled by ALiVE
	if (!(isPlayer (leader _x)) && (((leader _x) getVariable ["profileID", ""]) isEqualTo "")) then
	{
		_side = str(side _x);
		//if (_side isEqualTo "WEST") then {_side = "WEST";};
		//if (_side isEqualTo "EAST") then {_side = "EAST";};
		if (_side isEqualTo "GUER") then {_side = "INDEPENDENT";};
		if (_side isEqualTo "CIV") then {_side = "CIVILIAN";};
		if !(_side in ["WEST","EAST","INDEPENDENT","CIVILIAN"]) then {_side = "CIVILIAN";};
		_output pushBack format ["_group = createGroup [%1, true]; ", _side];
	};
	{
		// Unit cannot be a player or profiled by ALiVE
		if (!(isPlayer _x) && ((_x getVariable ["profileID", ""]) isEqualTo "")) then
		{
			_output pushBack format ["_unit = _group createUnit ['%1', [0,0,0], [], 0, 'CAN_COLLIDE']; ", (typeOf _x)];
			_output pushBack "[_unit] joinSilent _group; ";
			_output pushBack format ["_unit setDir %1; ", (getDir _x)];
			_output pushBack format ["_unit setPosWorld %1; ", (getPosWorld _x)];
			//_output pushBack format ["_unit switchMove '%1'; ", (animationState _x)];
			//_output pushBack "doStop _unit; ";
			_output pushBack format ["_unit setUnitLoadout %1; ", (getUnitLoadout _x)];
			// Add unit as curator editable object
			//_output pushBack "[OLDF_Curator_Admin, [[_unit], true]] remoteExec ['addCuratorEditableObjects', 2]; ";
			//_output pushBack "[OLDF_Curator_GM, [[_unit], true]] remoteExec ['addCuratorEditableObjects', 2]; ";
			_output pushBack format ["_unit setUnitPos '%1'; ", (unitPos _x)];
		};
	} forEach (units _x);
	// Dynamic simulation
	_output pushBack format ["_group enableDynamicSimulation %1; ", (dynamicSimulationEnabled _x)];
	// Waypoints
	_waypoints = waypoints _x;
	{
		if !((_x select 1) isEqualTo 0) then
		{
			private _wp_indx = (_x select 1);
			private _wp_posn = waypointPosition _x;
			private _wp_type = waypointType _x;
			private _wp_form = waypointFormation _x;
			private _wp_beha = waypointBehaviour _x;
			private _wp_comb = waypointCombatMode _x;
			private _wp_sped = waypointSpeed _x;
			_output pushBack format ["_group addWaypoint [%2, 0, %1]; ", _wp_indx, _wp_posn];
			_output pushBack format ["[_group, %1] setWaypointType '%2'; ", _wp_indx, _wp_type];
			_output pushBack format ["[_group, %1] setWaypointFormation '%2'; ", _wp_indx, _wp_form];
			_output pushBack format ["[_group, %1] setWaypointBehaviour '%2'; ", _wp_indx, _wp_beha];
			_output pushBack format ["[_group, %1] setWaypointCombatMode '%2'; ", _wp_indx, _wp_comb];
			_output pushBack format ["[_group, %1] setWaypointSpeed '%2'; ", _wp_indx, _wp_sped];
		};
	} forEach _waypoints;
} forEach _groups;

// Convert array to text
{
	_output_text = _output_text + _x;
} forEach _output;

// Output dialog
["Export", _output_text] call zen_common_fnc_exportText;