/*
 * Add/Spawn group from config.
 *
 * Arguments:
 * 0: Coordinate <ARRAY>
 * 1: Side <STRING>
 * 2: Faction <STRING>
 * 3: Type <STRING>
 * 4: Group <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0,0,0],"West","BLU_F","Infantry","BUS_InfSquad"] call STNE_fnc_server_addGroup;
 *
 */

params ["_spawnArray"];

private _Side = WEST;
switch (_spawnArray select 1) do {
    case "West": {_Side = WEST;};
    case "East": {_Side = EAST;};
    case "Indep": {_Side = INDEPENDENT;};
    case "Civ": {_Side = CIVILIAN;};
    case "Empty": {_Side = sideEmpty;};
    default {_Side = WEST;};
};

private _Group = [
	[((_spawnArray select 0) select 0), ((_spawnArray select 0) select 1), 0],
	_Side,
	(configFile >> "CfgGroups" >> (_spawnArray select 1) >> (_spawnArray select 2) >> (_spawnArray select 3) >> (_spawnArray select 4)),
    nil,
    nil,
    nil,
    nil,
    nil,
    0,
    nil,
    nil
] call BIS_fnc_spawnGroup;

if !(isNull _Group) then {
    // Add curator editable
    {
        private _Objects = (units _Group);
        {
            private _ParentObj = objectParent _x;
            if !(_ParentObj == objNull) then {
                _Objects pushBackUnique _ParentObj;
            };
        } forEach _Objects;
        _x addCuratorEditableObjects [_Objects, true];
    } forEach allCurators;

    // Delete group when empty
    _Group deleteGroupWhenEmpty true;
};