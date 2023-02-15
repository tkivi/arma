/*
 * EDEN: Get class loadouts from selected objects and copy them to clipboard.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Class names with all possible loadouts <ARRAY>
 *
 * Example:
 * [] call STNE_fnc_eden_getClassLoadouts;
 *
 */

if (is3DEN) then {
    private _ClassNames = [];
    private _ClassLoadouts = [];
    private _SelectedObjects = (get3DENSelected "object") select {_x isKindOf "Man"};
    {
        _ClassNames pushBackUnique (typeOf _x);
    } forEach _SelectedObjects;
    {
        private _ClassName = _x;
        private _Loadouts = [];
        {
            if (_ClassName isEqualTo (typeOf _x)) then {
                _Loadouts pushBack (getUnitLoadout _x);
            };
        } forEach _SelectedObjects;
        _ClassLoadouts pushBack [_ClassName, _Loadouts];
    } forEach _ClassNames;
    copyToClipboard (str _ClassLoadouts);
    _ClassLoadouts
};