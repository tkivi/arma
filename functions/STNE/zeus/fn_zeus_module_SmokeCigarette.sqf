// ZEUS MODULE: DCSARMA - Smoke Cigarette
if ("IMMERSIONCIGS" in STNE_server_Mods) then {
	["DCSARMA", "Smoke Cigarette",
		{
			private _module_position = param [0, [0,0,0], [[]]];
			private _selected_object = param [1, ObjNull, [ObjNull]];
			if (_selected_object isEqualTo objNull) then {
				["Place on an object"] call zen_common_fnc_showMessage;
			} else {
				[_selected_object] spawn {
					[(_this select 0),["murshun_cigs_cigpack",(ceil(random 10))]] remoteExec ["addMagazine", (_this select 0)];
					[(_this select 0),["murshun_cigs_matches",(ceil(random 10))]] remoteExec ["addMagazine", (_this select 0)];
					[(_this select 0)] remoteExec ["removeGoggles", (_this select 0)];
					[(_this select 0),"murshun_cigs_cig0"] remoteExec ["addGoggles", (_this select 0)];
					sleep 5;
					[(_this select 0)] remoteExec ["murshun_cigs_fnc_start_cig", (_this select 0)];
				};
			};
		}
	] call zen_custom_modules_fnc_register;
};