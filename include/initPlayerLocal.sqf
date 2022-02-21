/*/////////////////////////////////////////////////////////////////////////////////////

	Parameters:

	[player:Object, didJIP:Boolean]

/////////////////////////////////////////////////////////////////////////////////////*/

// Exit if player is not actual human player
if !(hasInterface) exitWith {};

// Wait until server init is done
waitUntil {sleep 1; !(isNil "STNE_server_Init")};

// Save loadout on respawn
if (missionNamespace getVariable ["STNE_respawn_Loadouts", false]) then {
	// Set/Save initial player loadout and traits
	private _stne_old_loadout = missionNamespace getVariable ["STNE_loadout_" + (getPlayerUID player), []];
	private _stne_old_traits = missionNamespace getVariable ["STNE_traits_" + (getPlayerUID player), []];
	if (count _stne_old_loadout > 0) then {
		player setUnitLoadout [_stne_old_loadout, true];
	} else {
		missionNamespace setVariable ["STNE_loadout_" + (getPlayerUID player), getUnitLoadout [player, true], true];
	};
	if (count _stne_old_traits > 0) then {
		{
			player setUnitTrait [(_x select 0), (_x select 1)];
		} forEach _stne_old_traits;
	} else {
		missionNamespace setVariable ["STNE_traits_" + (getPlayerUID player), getAllUnitTraits player, true];
	};

	if ("CBA" in STNE_server_Mods && "ACE" in STNE_server_Mods) then {
		// Save player loadout when closing ACE arsenal
		[
			"ace_arsenal_displayClosed", {
				missionNamespace setVariable ["STNE_loadout_" + (getPlayerUID player), getUnitLoadout [player, true], true];
				missionNamespace setVariable ["STNE_traits_" + (getPlayerUID player), getAllUnitTraits player, true];
			}
		] call CBA_fnc_addEventHandler;

		if ((count (missionNamespace getVariable ["STNE_arsenal_Loadouts", [[],[]]] select 0)) > 0) then {
			// Load loadout from ACE arsenal
			[
				"ace_arsenal_onLoadoutLoad", {
					params ["_stne_LoadoutArray", "_stne_LoadoutName"];
					{
						if ((_x select 0) == _stne_LoadoutName) exitwith {
							for "_i" from 1 to 10 do {systemChat " ";};
							systemChat format ["Loadout: %1", _stne_LoadoutName];
							{
								if (typeName (_x select 1) == "BOOL") then {
									if (_x select 1) then {
										systemChat format [" - %1 training received", (_x select 0)];
									};
								};
								player setUnitTrait [(_x select 0), (_x select 1)];
							} forEach (_x select 2);
						};
					} forEach (STNE_arsenal_Loadouts select 0);
				}
			] call CBA_fnc_addEventHandler;
		};
	};
};

// Briefing text
[] call STNE_fnc_briefing_addText;

// Add ZEUS modules
[] call STNE_fnc_zeus_addModules;

// Assign player object as curator if defined
[] spawn STNE_fnc_zeus_addZeus;