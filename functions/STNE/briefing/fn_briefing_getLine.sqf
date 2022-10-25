/*
 * Get formatted line for briefing text.
 *
 * Arguments:
 * 0: Uncolored text <STRING>
 * 1: Colored text <STRING>
 *
 * Return Value:
 * Formatted text line <STRING>
 *
 * Example:
 * ["Server: ", serverName] call STNE_fnc_briefing_getLine;
 *
 */

params ["_UnColored", "_Colored"];

private _Brk = "<br />";
private _Bgn = "<font color='" + STNE_color_HEX + "'>";
private _End = "</font>";

private _FormatUncolored = format ["%1", _UnColored];
private _FormatColored = format ["%1", _Colored];

if ((typeName _Colored) isEqualTo "ARRAY") then {
	_FormatColored = "";
	for "_i" from 0 to ((count _Colored) - 1) do {
		if (_i isEqualTo ((count _Colored) - 1)) then {
			_FormatColored = _FormatColored + (_Colored select _i)
		} else {
			_FormatColored = _FormatColored + (_Colored select _i) + ", ";
		};
	};
};

private _Return = _Brk + _FormatUncolored + _Bgn + _FormatColored + _End;
_Return