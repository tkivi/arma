/*
 * Add spectator ACE action.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_action_addSpectator;
 *
 */

params ["_selected_object"];

if ("ACE" in STNE_server_Mods) then {
	private _action = ["stne_view_spectator", "Spectate other players", "", {
		[allPlayers, [player]] call ace_spectator_fnc_updateUnits;
		[1, objNull] call ace_spectator_fnc_setCameraAttributes;
		if ("SOG" in STNE_server_Mods) then {
			[[-2], [-1, 0, 1, 2, 3, 4, 5, 6, 7]] call ace_spectator_fnc_updateVisionModes;
		} else {
			[[-2, -1, 0], [1, 2, 3, 4, 5, 6, 7]] call ace_spectator_fnc_updateVisionModes;
		};
		[true, false, false] call ace_spectator_fnc_setSpectator;
	}, {true}] call ace_interact_menu_fnc_createAction;
	[_selected_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};