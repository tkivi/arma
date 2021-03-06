/*
 * Add text to briefing.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_briefing_addText;
 *
 */

// Header
player createDiarySubject
[
	"dcsarma_briefing",
	"DCSARMA"
];

// Convert respawn number to string
private _RespawnType = "Unknown";
switch (getMissionConfigValue ["respawn", 99]) do {
	case 0: {_RespawnType = "NONE";};
	case 1: {_RespawnType = "BIRD";};
	case 2: {_RespawnType = "INSTANT";};
	case 3: {_RespawnType = "BASE";};
	case 4: {_RespawnType = "GROUP";};
	case 5: {_RespawnType = "SIDE";};
	default {_RespawnType = "Unknown";};
};

// Record
player createDiaryRecord
[
	"dcsarma_briefing",
	[
		"Mission Framework",
		format [
			"%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19",
			["Server: ", serverName] call STNE_fnc_briefing_getLine,
			["Map: ", getText (configfile >> "CfgWorlds" >> worldName >> "description")] call STNE_fnc_briefing_getLine,
			["Mission: ", briefingName] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Respawn type: ", _RespawnType] call STNE_fnc_briefing_getLine,
			["Respawn templates: ", getMissionConfigValue ["respawnTemplates", "Unknown"]] call STNE_fnc_briefing_getLine,
			["Respawn loadouts: ", missionNamespace getVariable ["STNE_respawn_Loadouts", false]] call STNE_fnc_briefing_getLine,
			["Respawn delay: ", getMissionConfigValue ["respawnDelay", "Unknown"]] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Default loadouts: ", count ((missionNamespace getVariable ["STNE_arsenal_Loadouts", [[],[]]]) select 0)] call STNE_fnc_briefing_getLine,
			["Custom server groups: ", count (missionNamespace getVariable ["STNE_server_CustomGroups", []])] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Extended Vehicle in Vehicle logistic: ", missionNamespace getVariable ["STNE_logistic_ViV", false]] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Sandbox: ", missionNamespace getVariable ["STNE_sandbox_Enabled", false]] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Version: ", "220316"] call STNE_fnc_briefing_getLine,
			["", ""] call STNE_fnc_briefing_getLine,
			["Mission Framework by Stone.", ""] call STNE_fnc_briefing_getLine
		]
	]
];

// Show info text middle of screen if in sandbox mode
if (missionNamespace getVariable ["STNE_sandbox_Enabled", false]) then {
	[] spawn {
		private _PlayerPos = getPos player;
		private _WelcomeText = [
			format ["Welcome to %1, %2 !", getText (configfile >> "CfgWorlds" >> worldName >> "description"), (player call BIS_fnc_position) call BIS_fnc_locationDescription],
			"Sandbox mode enabled",
			format ["Press %1 to enter Zeus mode", actionKeysNames "curatorInterface"] // https://community.bistudio.com/wiki/inputAction/actions
		];
		waitUntil {sleep 3; !(_PlayerPos isEqualTo (getPos player))};
		{
			[_x, 1, 10, [1,1,1,1], true] spawn BIS_fnc_WLSmoothText;
		} forEach _WelcomeText;
	};
};