/*
 * Add SOG arsenal.
 *
 * Arguments:
 * 0: Ammo box <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_arsenal_addSOG;
 *
 */

private _ArsenalBox = param [0, ObjNull, [ObjNull]];

if ("ACE" in STNE_server_Mods && "SOG" in STNE_server_Mods) then {
	private _VirtualArray = [];
	private _SOGWeapons = "'VN' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgWeapons") apply {configName _x};
	private _SOGMagazines = "'VN' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgMagazines") apply {configName _x};
	private _SOGGlasses = "'VN' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgGlasses") apply {configName _x};
	private _SOGBackpacks = "'VN' in (configSourceModList _x) && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'isBackpack') == 1" configClasses (configFile >> "CfgVehicles") apply {configName _x};
	{
		_VirtualArray pushBackUnique _x;
	} forEach _SOGWeapons + _SOGMagazines + _SOGGlasses + _SOGBackpacks;
	[_ArsenalBox, _VirtualArray, true] call ace_arsenal_fnc_initBox;
	[getArray (configFile >> "CfgPatches" >> "ace_medical_treatment" >> "weapons"), "Medical", nil, 0] call ace_arsenal_fnc_addRightPanelButton;
};