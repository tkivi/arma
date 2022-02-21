/*/////////////////////////////////////////////////////////////////////////////////////

	Parameters:

	[<newUnit>, <oldUnit>, <respawn>, <respawnDelay>]

/////////////////////////////////////////////////////////////////////////////////////*/

// Save loadout on respawn
if (missionNamespace getVariable ["STNE_respawn_Loadouts", false]) then {
	private _stne_new_unit = param [0, objNull, [objNull]];
	private _stne_old_loadout = missionNamespace getVariable ["STNE_loadout_" + (getPlayerUID player), []];
	private _stne_old_traits = missionNamespace getVariable ["STNE_traits_" + (getPlayerUID player), []];
	if (count _stne_old_loadout > 0) then {
		_stne_new_unit setUnitLoadout [_stne_old_loadout, true];
	};
	{
		_stne_new_unit setUnitTrait [(_x select 0), (_x select 1)];
	} forEach _stne_old_traits;
};