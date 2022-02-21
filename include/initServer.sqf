// Sandbox mode
if (missionNamespace getVariable ["STNE_sandbox_Enabled", false]) then {
	[] call STNE_fnc_arsenal_addSandbox;
};

// Set server viewDistance
if ((missionNamespace getVariable ["STNE_server_ViewDistance", 0]) > 0) then {
	[STNE_server_ViewDistance] call STNE_fnc_server_setViewDistance;
};

// Server init is done
STNE_server_Init = true;
publicVariable "STNE_server_Init";