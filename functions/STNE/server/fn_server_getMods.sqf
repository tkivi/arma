/*
 * Get activated mods.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_server_getMods;
 *
 */

STNE_server_Mods = [];
{
	if (isClass (configFile >> "CfgPatches" >> (_x select 0))) then {
		STNE_server_Mods pushBack (_x select 1);
	};
} forEach [
	["inidbi2", "INIDBI2"],
	["cba_main", "CBA"],
	["acre_main", "ACRE2"],
	["tfar_core", "TFAR"],
	["ace_main", "ACE"],
	["acex_main", "ACEX"],
	["alive_main", "ALIVE"],
	["achilles_functions_f_achilles", "ACHILLES"],
	["zen_main", "ZEN"],
	["ar_advancedrappelling", "ADVRAPPELLING"],
	["ats_advancedtrainsimulator", "ADVTRAINSIMULATOR"],
	["aur_advancedurbanrappelling", "ADVURBANRAPPELLING"],
	["sa_advancedslingloading", "ADVSLINGLOADING"],
	["sa_advancedtowing", "ADVTOWING"],
	["rhs_main", "RHS"],
	["cup_ca_data", "CUP"],
	["ffaa_data", "FFAA"],
	["VCOM_AI", "VCOM_AI"],
	["IFA3_Core", "IFA3"],
	["NORTH_Main", "NORTHERNFRONTS"],
	["murshun_cigs", "IMMERSIONCIGS"],
	["MRHSatellite", "MRHSATELLITE"],
	["cTab", "CTAB"],
	["vn_misc", "SOG"],
	["Bum_BlindZeus", "BLINDZEUS"]
];
publicVariable "STNE_server_Mods";