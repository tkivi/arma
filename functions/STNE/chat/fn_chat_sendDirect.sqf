/*
 * Send direct chat message.
 *
 * Arguments:
 * Object <OBJECT>
 * Message <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object, "Message"] spawn STNE_fnc_chat_sendDirect;
 *
 */

// Params
private _Object = param [0, objNull, [objNull]];
private _Message = param [1, "", [""]];

if (_Object isEqualTo objNull || _Message isEqualTo "" || !(hasInterface)) exitWith {};

private _HearingDistance = 15;
private _MessageArray = _Message splitString ",.";
private _MessageHeard = "";
private _ObjectName = name _Object;

// Show message
{
	if (alive _Object) then {
		private _SleepTime = (count (_x splitString " ")) + 3;
		_Object setRandomLip true;
		private _SoundObject = _Object say3D "Crowd2";
		if ((player distance _Object) < _HearingDistance && alive player) then {
			[_ObjectName, _x, _SleepTime, 0] call STNE_fnc_chat_showSubtitle;
			_MessageHeard = _MessageHeard + _x;
			sleep _SleepTime;
		} else {
			sleep _SleepTime;
		};
		_Object setRandomLip false;
		deleteVehicle _SoundObject;
	};
} forEach _MessageArray;

// Create diary record
if !(_MessageHeard isEqualTo "") then {
	player createDiarySubject [
		"DCSARMA_chat_Direct",
		"Conversations"
	];
	player createDiaryRecord [
		"DCSARMA_chat_Direct",
		[
			"Conversations",
			format ["<font color='%1'>%2:</font> %3", STNE_color_RGBA call BIS_fnc_colorRGBtoHTML, _ObjectName, _MessageHeard]
		],
		taskNull,
		"",
		false
	];
};