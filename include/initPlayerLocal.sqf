/*/////////////////////////////////////////////////////////////////////////////////////

	Parameters:

	[player:Object, didJIP:Boolean]

/////////////////////////////////////////////////////////////////////////////////////*/

// Exit if player is not actual human player
if !(hasInterface) exitWith {};

// Set black screen if loading from database = hide possible player relocation
if (missionNamespace getVariable ["STNE_database_Enabled", false]) then {
	if ("INIDBI2" in STNE_server_Mods) then {
		titleText ["Reading database, please wait...", "BLACK", 0.001];
	};
};

// Wait until player
waitUntil {!isNull player};

// Briefing text
[] call STNE_fnc_briefing_addText;

// Wait until server init is done
waitUntil {sleep 1; !(isNil "STNE_server_Init")};

// Keep selected loadout on respawn
if (missionNamespace getVariable ["STNE_loadout_Respawn", false]) then {
	if ("CBA" in STNE_server_Mods && "ACE" in STNE_server_Mods) then {
		// Save player loadout when closing ACE arsenal
		[
			"ace_arsenal_displayClosed", {
				missionNamespace setVariable ["STNE_loadout_" + (getPlayerUID player), getUnitLoadout [player, true], true];
				missionNamespace setVariable ["STNE_traits_" + (getPlayerUID player), getAllUnitTraits player, true];
			}
		] call CBA_fnc_addEventHandler;
		// Load loadout from ACE arsenal
		if ((count (missionNamespace getVariable ["STNE_loadout_Arsenal", [[],[]]] select 0)) > 0) then {
			[
				"ace_arsenal_onLoadoutLoad", {
					params ["_LoadoutArray", "_LoadoutName"];
					{
						if ((_x select 0) == _LoadoutName) exitwith {
							for "_i" from 1 to 10 do {systemChat " ";};
							systemChat format ["Loadout: %1", _LoadoutName];
							{
								if (typeName (_x select 1) == "BOOL") then {
									if (_x select 1) then {
										systemChat format [" - %1 training received", (_x select 0)];
									};
								};
								player setUnitTrait [(_x select 0), (_x select 1)];
							} forEach (_x select 2);
						};
					} forEach (STNE_loadout_Arsenal select 0);
				}
			] call CBA_fnc_addEventHandler;
		};
	};
};

// Add ZEUS actions and modules
[] call STNE_fnc_zeus_addActions;
[] call STNE_fnc_zeus_addModules;

// Show info text middle of screen if in sandbox zeus mode
if (missionNamespace getVariable ["STNE_sandbox_Zeus", false]) then {
	[] spawn {
		waitUntil {sleep 1; !(isNull (getAssignedCuratorLogic player))};
		private _WelcomeText = [
			format ["Welcome to %1, %2 !", getText (configfile >> "CfgWorlds" >> worldName >> "description"), (player call BIS_fnc_position) call BIS_fnc_locationDescription],
			format ["Press %1 to enter Zeus mode", actionKeysNames "curatorInterface"] // https://community.bistudio.com/wiki/inputAction/actions
		];
		{
			[_x, 1, 10, [1,1,1,1], true] spawn BIS_fnc_WLSmoothText;
		} forEach _WelcomeText;
	};
};