// UnitPlay
private _ActionUnitPlay = [
	"STNE_UnitPlay",
	"Run UnitPlay Route",
	STNE_icon_Play,
	{
		{
			if !((_x getvariable ["STNE_unitplay_Params", []]) isEqualTo []) then {
				(_x getvariable ["STNE_unitplay_Params", []]) remoteExec ["STNE_fnc_server_runUnitPlay", _x];
			};
		} forEach ((_this select 1) select {!((_x getvariable ["STNE_unitplay_Params", []]) isEqualTo [])});
	},
	{
		count ((_this select 1) select {!((_x getvariable ["STNE_unitplay_Params", []]) isEqualTo [])}) > 0
	}
] call zen_context_menu_fnc_createAction;
[_ActionUnitPlay, [], 0] call zen_context_menu_fnc_addAction;