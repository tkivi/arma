/*
 * Add modules for Zeus enchanced mod.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_zeus_addModules;
 *
 */

if ("ZEN" in STNE_server_Mods) then {
	{
		call compile preprocessFileLineNumbers format ["functions\STNE\zeus\fn_zeus_module_%1.sqf", _x];
	} forEach [
		"AddLoadoutActions",
		"AddLoadoutArsenal",
		"AddMedicalArsenal",
		"AddSOGArsenal",
		"AddRespawn",
		"AddSatelliteTV",
		"AddSpectator",
		"ChangeServerSettings",
		"SmokeCigarette",
		"SpawnServerGroup",
		"SpawnServerGroupCustom",
		"ToggleDynamicSimulation"
	];
};