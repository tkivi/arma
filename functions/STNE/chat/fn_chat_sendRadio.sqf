/*
 * Send chat message via radio.
 *
 * Arguments:
 * Name <STRING>
 * Message <STRING>
 * Frequency <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Sender", "Message", "Frequency"] spawn STNE_fnc_chat_sendRadio;
 *
 */

// Params
private _Sender = param [0, "", [""]];
private _Message = param [1, "", [""]];
private _Frequency = param [2, "", [""]];

if (_Message isEqualTo "" || !(hasInterface)) exitWith {};

private _HasRadio = false;
private _MessageArray = _Message splitString ",.";
private _MessageHeard = "";

// Check if player has radio
if ("TFAR" in STNE_server_Mods) then {
	private _TFAR_Frequency = [];
	private _TFAR_HasLr = (call TFAR_fnc_haveLRRadio);
	private _TFAR_HasSw = (call TFAR_fnc_haveSWRadio);
	if (_TFAR_HasLr) then {
		private _TFAR_Lr = (call TFAR_fnc_ActiveLrRadio);
		_TFAR_Frequency pushBack ([_TFAR_Lr, (_TFAR_Lr call TFAR_fnc_getLrChannel) + 1] call TFAR_fnc_GetChannelFrequency);
		_TFAR_Frequency pushBack ([_TFAR_Lr, (_TFAR_Lr call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency);
	};
	if (_TFAR_HasSw) then {
		private _TFAR_Sw = (call TFAR_fnc_ActiveSwRadio);
		_TFAR_Frequency pushBack ([_TFAR_Sw, (_TFAR_Sw call TFAR_fnc_getSwChannel) + 1] call TFAR_fnc_GetChannelFrequency);
		_TFAR_Frequency pushBack ([_TFAR_Sw, (_TFAR_Sw call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency);
	};
	if (_Frequency in _TFAR_Frequency) then {
		_HasRadio = true;
	};
} else {
	{
		if ("ItemRadioAcreFlagged" in _x || "ItemRadio" in _x) then {
			_HasRadio = true;
		};
	} forEach (assignedItems player);
};

//leader (group player) isEqualTo player

// Show message
if (_HasRadio && alive player) then {
	{
		private _SleepTime = (count (_x splitString " ")) + 3;
		playSoundUI ["a3\dubbing_radio_f\sfx\in2a.ogg", 1, 1, false];
		[_Sender, _x, _SleepTime, 1] call STNE_fnc_chat_showSubtitle;
		_MessageHeard = _MessageHeard + _x;
		sleep _SleepTime;
		playSoundUI ["a3\dubbing_radio_f\sfx\out2a.ogg", 1, 1, false];
	} forEach _MessageArray;
};

// Create diary record
if !(_MessageHeard isEqualTo "") then {
	player createDiarySubject [
		"DCSARMA_chat_Radio",
		"Radio Messages"
	];
	player createDiaryRecord [
		"DCSARMA_chat_Radio",
		[
			"Radio Messages",
			format ["<font color='%1'>%2:</font> %3", STNE_color_RGBA_side call BIS_fnc_colorRGBtoHTML, _Sender, _MessageHeard]
		],
		taskNull,
		"",
		false
	];
};