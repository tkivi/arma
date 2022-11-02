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
		"AddRespawn",
		"AddSatelliteTV",
		"AddSOGArsenal",
		"AddSpectator",
		"AddUnitDamage",
		"AddWSArsenal",
		"AICharge",
		"ChangeServerSettings",
		"CreateSQF",
		"DatabaseGenerateID",
		"DatabaseRemoveID",
		"DatabaseShowID",
		"DatabaseWrite",
		"PlayMusic",
		"PlaySound",
		"SmokeCigarette",
		"SpawnServerGroup",
		"SpawnServerGroupCustom",
		"ToggleDynamicSimulation",
		"TraceBullets",
		"UnitPlay",
		"UnitPlayRecord"
	];
};