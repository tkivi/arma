// AI EnableAttack
if (missionNamespace getVariable ["STNE_ai_EnableAttack", true]) then {
	// Default, do nothing
} else {
	if ("CBA" in STNE_server_Mods) then {
		["Man", "init", {
			if !(isPlayer (_this select 0)) then {
				(_this select 0) enableAttack false;
			};
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	};
};