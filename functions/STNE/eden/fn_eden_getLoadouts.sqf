/*
 * EDEN: Get loadouts from playable units and copy them to clipboard.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Loadouts <ARRAY>
 *
 * Example:
 * [] call STNE_fnc_eden_getLoadouts;
 *
 */

if (is3DEN) then {
    private _AllItems = [];
    private _Loadouts = [];
    // Get loadouts
    {
        private _ArsenalName = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
        private _Description = (_x get3DENAttribute "description") select 0;
        if !(_Description isEqualTo "") then {
            _ArsenalName = _Description;
        };
        private _UnitLoadout = getUnitLoadout [_x, true];
        private _UnitTraits = getAllUnitTraits _x;
        private _FlattenUnitLoadout = flatten _UnitLoadout;
        _FlattenUnitLoadout = _FlattenUnitLoadout arrayIntersect _FlattenUnitLoadout select {_x isEqualType "" && {_x != ""}};
        _Loadouts append [[_ArsenalName, _UnitLoadout, _UnitTraits]];
        {
            _AllItems pushBackUnique _x;
        } forEach _FlattenUnitLoadout;
    } forEach playableUnits;

    private _Combined = [_Loadouts, _AllItems];
    copyToClipboard (str _Combined);
    _Combined
};