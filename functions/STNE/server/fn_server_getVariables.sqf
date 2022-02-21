/*
 * Get global STNE variables.
 *
 * Arguments:
 * 0: Part of name <STRING> (optional)
 *
 * Return Value:
 * Variable names <ARRAY>
 *
 * Example:
 * [] call STNE_fnc_server_getVariables;
 *
 */

private _Return = [];
{
	private _CustomName = toUpper (param [0, "", [""]]);
	private _VarName = toUpper _x;
	if (("STNE_" in _VarName) && !("_FNC_" in _VarName) && (_CustomName in _VarName)) then {
		_Return pushBack _x;
	};
} foreach (allVariables missionNamespace);
_Return