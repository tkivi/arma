/*
 * Add Satellite TV ACE action.
 *
 * Arguments:
 * 0: Screen object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_action_addSatelliteTV;
 *
 */

params ["_selected_object"];

if ("ACE" in STNE_server_Mods && "MRHSATELLITE" in STNE_server_Mods) then {
	private _action = ["stne_view_satellite", "View satellite", "", {[_target] call MRH_fnc_IsSatMonitor}, {true}] call ace_interact_menu_fnc_createAction;
	[_selected_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};