/*
 * EDEN: Get class names from selected objects and copy them to clipboard.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Class names <ARRAY>
 *
 * Example:
 * [] call STNE_fnc_eden_getClassNames;
 *
 */

if (is3DEN) then {
    private _ObjectNames = [];
    private _SelectedObjects = get3DENSelected "object";
    {
        _ObjectNames pushBack (typeOf _x);
    } forEach _SelectedObjects;
    private _Combined = ["Insert GroupName", _ObjectNames];
    copyToClipboard (str _Combined);
    _Combined
};