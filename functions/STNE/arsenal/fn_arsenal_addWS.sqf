/*
 * Add Western Sahara arsenal.
 *
 * Arguments:
 * 0: Ammo box <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_arsenal_addWS;
 *
 */

private _ArsenalBox = param [0, ObjNull, [ObjNull]];

if ("ACE" in STNE_server_Mods && "WS" in STNE_server_Mods) then {
	private _VirtualArray = [];
	private _WSWeapons = "'WS' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgWeapons") apply {configName _x};
	private _WSMagazines = "'WS' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMagazines") apply {configName _x};
	private _WSGlasses = "'WS' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgGlasses") apply {configName _x};
	private _WSBackpacks = "'WS' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'isBackpack') == 1" configClasses (configFile >> "CfgVehicles") apply {configName _x};
	{
		_VirtualArray pushBackUnique _x;
	} forEach _WSWeapons + _WSMagazines + _WSGlasses + _WSBackpacks;
	[_ArsenalBox, _VirtualArray, true] call ace_arsenal_fnc_initBox;
	[getArray (configFile >> "CfgPatches" >> "ace_medical_treatment" >> "weapons"), "Medical", nil, 0] call ace_arsenal_fnc_addRightPanelButton;
};