// ZEUS MODULE: DCSARMA - Toggle Dynamic Simulation
["DCSARMA", "Toggle Dynamic Simulation",
    {
        private _module_position = param [0, [0,0,0], [[]]];
        private _selected_object = param [1, ObjNull, [ObjNull]];
        if (_selected_object isEqualTo objNull) then {
            ["Place on an object"] call zen_common_fnc_showMessage;
        } else {
            [_selected_object] remoteExec ["STNE_fnc_server_toggleDynamicSimulation", 2];
        };
    }
] call zen_custom_modules_fnc_register;