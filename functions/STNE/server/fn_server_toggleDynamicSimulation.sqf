/*
 * Toggle unit group Dynamic Simulation.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_server_toggleDynamicSimulation;
 *
 */

private _Object = param [0, objNull, [objNull]];

if !(isNull _Object) then {
	private _Group = group _Object;
	if !(isNull _Group) then {
		if (dynamicSimulationEnabled _Group) then {
			[_Group, false] remoteExec ["enableDynamicSimulation", 0, true];
		} else {
			[_Group, true] remoteExec ["enableDynamicSimulation", 0, true];
		};
	};
};