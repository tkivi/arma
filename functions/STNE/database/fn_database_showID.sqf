/*
 * Show generated IDs in Zeus interface.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [] call STNE_fnc_database_showID;
 *
 */

private _Return = false;

if (isNil "STNE_database_ZeusIcons") then {
	STNE_database_ZeusIcons = [];
	{
		if !(_x getVariable ["STNE_database_ID", ""] isEqualTo "") then {
			private _Icon = [
				(getAssignedCuratorLogic player),
				[
					STNE_icon_Save,
					STNE_color_RGBA,
					_x,
					1,
					1,
					1,
					_x getVariable ["STNE_database_ID", ""],
					true,
					0.03,
					"PuristaMedium"
				],
				true
			] call BIS_fnc_addCuratorIcon;
			STNE_database_ZeusIcons pushBack _Icon;
		};
	} forEach STNE_database_AllObjects; // allMissionObjects "All"; // (8 allObjects 1);
	_Return = true;
} else {
	{
		[(getAssignedCuratorLogic player), _x] call BIS_fnc_removeCuratorIcon;
	} forEach STNE_database_ZeusIcons;
	STNE_database_ZeusIcons = nil;
};
_Return;

/*
if (isNil "STNE_database_DrawIcons") then {
	STNE_database_DrawIcons = addMissionEventHandler ["Draw3D",
		{
			drawIcon3D [
				STNE_icon_Save,
				STNE_color_RGBA,
				ASLToAGL getPosASLVisual cursorTarget,
				1,
				1,
				1,
				(cursorTarget getVariable ["STNE_database_ID", ""]),
				true,
				0.05,
				"PuristaMedium"
			];
		}
	];
} else {
	removeMissionEventHandler ["Draw3D", STNE_database_DrawIcons];
	STNE_database_DrawIcons = nil;
};
*/