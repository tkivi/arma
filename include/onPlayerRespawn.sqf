/*/////////////////////////////////////////////////////////////////////////////////////

	Parameters:

	[<newUnit>, <oldUnit>, <respawn>, <respawnDelay>]

/////////////////////////////////////////////////////////////////////////////////////*/

// Save loadout on respawn
if (missionNamespace getVariable ["STNE_loadout_Respawn", false]) then {
	private _NewUnit = param [0, objNull, [objNull]];
	private _OldLoadout = missionNamespace getVariable ["STNE_loadout_" + (getPlayerUID player), []];
	private _OldTraits = missionNamespace getVariable ["STNE_traits_" + (getPlayerUID player), []];
	if (count _OldLoadout > 0) then {
		_NewUnit setUnitLoadout [_OldLoadout, true];
	};
	{
		_NewUnit setUnitTrait [(_x select 0), (_x select 1)];
	} forEach _OldTraits;
};