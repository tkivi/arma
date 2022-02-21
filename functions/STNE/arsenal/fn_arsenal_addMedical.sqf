/*
 * Add ACE medical arsenal.
 *
 * Arguments:
 * 0: Ammo box <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_arsenal_addMedical;
 *
 */

private _ArsenalBox = param [0, ObjNull, [ObjNull]];

if ("ACE" in STNE_server_Mods) then {
	private _VirtualArray = getArray (configFile >> "CfgPatches" >> "ace_medical_treatment" >> "weapons");
	[_ArsenalBox, _VirtualArray, true] call ace_arsenal_fnc_initBox;
	[getArray (configFile >> "CfgPatches" >> "ace_medical_treatment" >> "weapons"), "Medical", nil, 0] call ace_arsenal_fnc_addRightPanelButton;
};