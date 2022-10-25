/*
 * Add arsenal box at every respawn location.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call STNE_fnc_arsenal_addSandbox;
 *
 */

{
	if ("RESPAWN" in (toUpper _x)) then {
		if ("CBA" in STNE_server_Mods && "ACE" in STNE_server_Mods) then {
			// ARSENAL
			private _FullArsenalBox = "Box_NATO_Equip_F" createVehicle (markerPos _x);
			clearWeaponCargoGlobal _FullArsenalBox;
			clearMagazineCargoGlobal _FullArsenalBox;
			clearBackpackCargoGlobal _FullArsenalBox;
			clearItemCargoGlobal _FullArsenalBox;
			[_FullArsenalBox, true, true] call ace_arsenal_fnc_initBox;
			private _MarkerName = format ["ARSENAL_%1", (toUpper _x)];
			private _MarkerColor = "ColorBlack";
			private _MarkerType = "respawn_inf";
			private _MarkerText = "Infantry Respawn | Arsenal";
			if ("WEST" in (toUpper _x)) then {_MarkerColor = "ColorWEST";};
			if ("EAST" in (toUpper _x)) then {_MarkerColor = "ColorEAST";};
			if ("GUERRILA" in (toUpper _x)) then {_MarkerColor = "ColorGUER";};
			if ("CIVILIAN" in (toUpper _x)) then {_MarkerColor = "ColorCIV";};
			if (_MarkerColor == "ColorBlack") then {
				_MarkerType = "respawn_unknown";
				_MarkerText = "Arsenal";
			};
			createMarker [_MarkerName, _FullArsenalBox, 0];
			_MarkerName setMarkerShape "ICON";
			_MarkerName setMarkerType _MarkerType;
			_MarkerName setMarkerText _MarkerText;
			_MarkerName setMarkerColor _MarkerColor;
			// LOADOUTS
			if ((count (missionNamespace getVariable ["STNE_loadout_Arsenal", [[],[]]] select 0)) > 0) then {
				private _LoadoutBox = "Box_NATO_Support_F" createVehicle (markerPos _x);
				clearWeaponCargoGlobal _LoadoutBox;
				clearMagazineCargoGlobal _LoadoutBox;
				clearBackpackCargoGlobal _LoadoutBox;
				clearItemCargoGlobal _LoadoutBox;
				["STNE_event_addLoadouts", _LoadoutBox] call CBA_fnc_globalEventJIP;
				[_LoadoutBox] call STNE_fnc_arsenal_addLoadouts;
			};
			// SPECTATOR
			private _SatelliteTV = "Land_TripodScreen_01_large_black_F" createVehicle (markerPos _x);
			["STNE_event_addSpectator", _SatelliteTV] call CBA_fnc_globalEventJIP;
			// MRHSATELLITE
			if ("MRHSATELLITE" in STNE_server_Mods) then {
				private _SatelliteBox = "MRH_SAT_protectiveCase" createVehicle (markerPos _x);
				["STNE_event_addSatelliteTV", _SatelliteTV] call CBA_fnc_globalEventJIP;
			};
			// CTAB
			if ("CTAB" in STNE_server_Mods) then {
				private _cTabBox = "Box_cTab_items" createVehicle (markerPos _x);
			};
			// SOG
			if ("SOG" in STNE_server_Mods) then {
				private _SOGBox = "vn_b_ammobox_12" createVehicle (markerPos _x);
				[_SOGBox] call STNE_fnc_arsenal_addSOG;
			};
		};
	};
} forEach allMapMarkers;