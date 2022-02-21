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
private _Bgn = "<font color='" + STNE_server_Color + "'>";
private _End = "</font>";

private _Return = _Brk + format ["%1", _UnColored] + _Bgn + format ["%1", _Colored] + _End;
_Return