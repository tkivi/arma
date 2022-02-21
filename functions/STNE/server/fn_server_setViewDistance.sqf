/*
 * Set server viewdistance and objectviewdistance.
 *
 * Arguments:
 * 0: ViewDistance <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [2500] call STNE_fnc_server_setViewDistance;
 *
 */

STNE_server_ViewDistance = param [0, 2500, [0]];

[STNE_server_ViewDistance] remoteExec ["setViewDistance", 2];
[[STNE_server_ViewDistance, 200]] remoteExec ["setObjectViewDistance", 2];
publicVariable "STNE_server_ViewDistance";