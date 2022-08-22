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

// Bug fix: https://feedback.bistudio.com/T126030
// MPclient can't take items in deadbody's vest/uniform/bag When change equipments on eden.
{
	_x setUnitLoadout (getUnitLoadout _x);
} forEach (allUnits - playableUnits);