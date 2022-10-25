/*
 * Add ACE Arsenal to object and set default loadouts.
 *
 * Arguments:
 * 0: Ammo box <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_arsenal_addLoadouts;
 *
 */

private _ArsenalBox = param [0, ObjNull, [ObjNull]];

if ("ACE" in STNE_server_Mods) then {
	if ((count (missionNamespace getVariable ["STNE_loadout_Arsenal", [[],[]]] select 0)) > 0) then {
		if (local _ArsenalBox) then {
			[_ArsenalBox, (STNE_loadout_Arsenal select 1)] call ace_arsenal_fnc_initBox;
			{
				private _DefaultName = (_x select 0);
				private _DefaultLoadout = (_x select 1);
				[_DefaultName, _DefaultLoadout] remoteExec ["ace_arsenal_fnc_addDefaultLoadout", 0, true];
			} forEach (STNE_loadout_Arsenal select 0);
			[getArray (configFile >> "CfgPatches" >> "ace_medical_treatment" >> "weapons"), "Medical", nil, 0] call ace_arsenal_fnc_addRightPanelButton;
		};
	};
};