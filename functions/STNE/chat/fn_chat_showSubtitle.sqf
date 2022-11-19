/*
 * Show subtitles.
 *
 * Arguments:
 * Name <STRING>
 * Text <STRING>
 * Time <NUMBER>
 * Type <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Name", "Text", 5, 1] call STNE_fnc_chat_showSubtitle;
 *
 */

// Params
private _Name = param [0, "", [""]];
private _Text = param [1, "", [""]];
private _Time = param [2, 0, [0]];
private _Type = param [3, 0, [0]];

if (_Text isEqualTo "" || !(hasInterface)) exitWith {};

private _Size = 0.6;
private _ColorName = STNE_color_RGBA_common;
private _ColorText = STNE_color_RGBA_common;

switch (_Type) do {
	case 1: {
		_ColorName = STNE_color_RGBA_side;
	};
	default {
		_ColorName = STNE_color_RGBA;
	};
};

_ColorName = _ColorName call BIS_fnc_colorRGBtoHTML;
_ColorText = _ColorText call BIS_fnc_colorRGBtoHTML;

private _TextFormat = format ["<t color='%1' size='%2'>%3</t><br/><t color='%4' size='%5'> %6</t>", _ColorName, _Size, _Name, _ColorText, _Size, _Text];

[
	_TextFormat,
	(safeZoneX + (0.5 * safeZoneW - ((0.42 * safeZoneW) / 2))),
	(safeZoneY + (0.8 * safeZoneH)),
	_Time,
	0,
	0,
	789
] spawn BIS_fnc_dynamicText;