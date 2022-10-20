# ARMA Mission Framework for DCS Finland community

Version: 221020

Edit [**config\config.hpp**](config/config.hpp) and [**config\config.sqf**](config/config.sqf) for your mission needs.

(optional) You can add your custom music [**config\music.hpp**](config/music.hpp) or sound [**config\sound.hpp**](config/sound.hpp).

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
