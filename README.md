# ARMA Mission Framework for DCS Finland community

Version: 221102

Edit [**config\config.hpp**](config/config.hpp) and [**config\config.sqf**](config/config.sqf) for your mission needs.

(optional) You can add your custom music to [**config\music.hpp**](config/music.hpp) or sound to [**config\sound.hpp**](config/sound.hpp).

(optional) You can add UnitPlay capture data to [**config\unitplay.sqf**](config/unitplay.sqf).

Add your custom briefing script commands to [**initBriefing.sqf**](initBriefing.sqf) if needed.

Usable functions that you can add to object init line:
- **Add mousewheel actions to object for quick loadout selection**
  >*[this] call STNE_fnc_action_addLoadouts;*
- **Add ACE action to object for MRHSatellite TV screen**
  >*[this] call STNE_fnc_action_addSatelliteTV;*
- **Add ACE action to object for ACE Spectator**
  >*[this] call STNE_fnc_action_addSpectator;*
- **Add ACE arsenal to object with default loadout gear only**
  >*[this] call STNE_fnc_arsenal_addLoadouts;*
- **Add ACE arsenal to object with medical gear only**
  >*[this] call STNE_fnc_arsenal_addMedical;*
- **Add ACE arsenal to object with SOG gear only**
  >*[this] call STNE_fnc_arsenal_addSOG;*
- **Add ACE arsenal to object with Western Sahara gear only**
  >*[this] call STNE_fnc_arsenal_addWS;*

Database:
- **Init line: Add object/static from editor to database save**
  >*if (isServer) then {[this] call STNE_fnc_database_generateID;};*
- **Trigger: Save all data to database**
  >*if (isServer) then {[] call STNE_fnc_database_writeDatabase;};*

UnitPlay:
- **Trigger: Run UnitPlay Track, params [Object, "TrackName", EngineOff, ResetLocation, UnloadCargo]**
  >*[Helicopter, "UnloadCargo", true, false, true] remoteExec ["STNE_fnc_server_runUnitPlay", Helicopter];*
