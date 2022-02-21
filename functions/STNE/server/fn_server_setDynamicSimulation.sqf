/*
 * Set server dynamic simulation settings.
 *
 * Arguments:
 * 0: Enabled <BOOLEAN>
 * 1: Distance, Group <NUMBER>
 * 2: Distance, Vehicle <NUMBER>
 * 3: Distance, Prop <NUMBER>
 * 4: Distance, EmptyVehicle <NUMBER>
 * 5: Modifier, IsMoving <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [2500] call STNE_fnc_server_setDynamicSimulation;
 *
 */

private _Enabled = param [0, false, [false]];
private _Group = param [1, 500, [0]];
private _Vehicle = param [2, 350, [0]];
private _Prop = param [3, 50, [0]];
private _EmptyVehicle = param [4, 250, [0]];
private _IsMoving = param [5, 2, [0]];

[_Enabled] remoteExec ["enableDynamicSimulationSystem", 0, true];
["Group", _Group] remoteExec ["setDynamicSimulationDistance", 0, true];
["Vehicle", _Vehicle] remoteExec ["setDynamicSimulationDistance", 0, true];
["Prop", _Prop] remoteExec ["setDynamicSimulationDistance", 0, true];
["EmptyVehicle", _EmptyVehicle] remoteExec ["setDynamicSimulationDistance", 0, true];
["IsMoving", _IsMoving] remoteExec ["setDynamicSimulationDistanceCoef", 0, true];