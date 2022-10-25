/*
 * Add loadout addaction to object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call STNE_fnc_action_addLoadouts;
 *
 */

params ["_selected_object"];

if ((count (missionNamespace getVariable ["STNE_loadout_Arsenal", [[],[]]] select 0)) > 0) then {
    {
        _selected_object addAction
        [
            format ["- Loadout: <t color='" + STNE_color_HEX + "'>%1</t>", (_x select 0)],
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _caller setUnitLoadout [(_arguments select 1), true];
                for "_i" from 1 to 10 do {systemChat " ";};
                systemChat format ["Loadout: %1", (_arguments select 0)];
                {
                    if (typeName (_x select 1) == "BOOL") then {
                        if (_x select 1) then {
                            systemChat format [" - %1 training received", (_x select 0)];
                        };
                    };
                    _caller setUnitTrait [(_x select 0), (_x select 1)];
                } forEach (_arguments select 2);
                missionNamespace setVariable ["STNE_loadout_" + (getPlayerUID player), getUnitLoadout [player, true], true];
                missionNamespace setVariable ["STNE_traits_" + (getPlayerUID player), getAllUnitTraits player, true];
            },
            _x,     // arguments
            1.5,    // priority
            false,  // showWindow
            true,   // hideOnUse
            "",     // shortcut
            "true", // condition
            5,      // radius
            false,  // unconscious
            "",     // selection
            ""      // memoryPoint
        ];
    } forEach (STNE_loadout_Arsenal select 0);
};