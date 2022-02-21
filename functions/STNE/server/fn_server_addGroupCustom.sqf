/*
 * Add/Spawn group from custom array.
 *
 * Arguments:
 * 0: Coordinate <ARRAY>
 * 1: Side <SIDE>
 * 2: Custom class names <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0,0,0],WEST,["vn_b_men_sog_22","vn_b_men_sog_22"]] call STNE_fnc_server_addGroupCustom;
 *
 */

params ["_Coordinate","_Side","_ClassNames"];

private _Group = [
	[(_Coordinate select 0), (_Coordinate select 1), 0],
	_Side,
	_ClassNames,
    nil,
    nil,
    nil,
    nil,
    nil,
    0,
    nil,
    nil
] call BIS_fnc_spawnGroup;

if !(isNull _Group) then {
    // Add curator editable
    {
        private _Objects = (units _Group);
        {
            private _ParentObj = objectParent _x;
            if !(_ParentObj == objNull) then {
                _Objects pushBackUnique _ParentObj;
            };
        } forEach _Objects;
        _x addCuratorEditableObjects [_Objects, true];
    } forEach allCurators;

    // Delete group when empty
    _Group deleteGroupWhenEmpty true;
};