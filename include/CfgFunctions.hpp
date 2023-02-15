//class CfgFunctions {
	class STNE {
		class config {
			file = "functions\STNE\config";
			class config_getConfig {file = "config\config.sqf"; preInit = 1;};
			class config_addCommon {preInit = 1;};
		};
		class action {
			file = "functions\STNE\action";
			class action_addLoadouts {};
			class action_addSatelliteTV {};
			class action_addSpectator {};
		};
		class ai {
			file = "functions\STNE\ai";
			class ai_charge {};
		};
		class arsenal {
			file = "functions\STNE\arsenal";
			class arsenal_addLoadouts {};
			class arsenal_addMedical {};
			class arsenal_addSandbox {};
			class arsenal_addSOG {};
			class arsenal_addWS {};
		};
		class briefing {
			file = "functions\STNE\briefing";
			class briefing_addText {};
			class briefing_getLine {};
		};
		class chat {
			file = "functions\STNE\chat";
			class chat_sendDirect {};
			class chat_sendRadio {};
			class chat_showSubtitle {};
		};
		class database {
			file = "functions\STNE\database";
			class database_generateID {};
			class database_getType {};
			class database_hasInventory {};
			class database_loadBuilding {};
			class database_loadMarkers {};
			class database_loadMines {};
			class database_loadObject {};
			class database_loadPlayer {};
			class database_loadStatic {};
			class database_loadWreck {};
			class database_readDatabase {};
			class database_removeID {};
			class database_saveBuilding {};
			class database_saveMarkers {};
			class database_saveMines {};
			class database_saveObject {};
			class database_savePlayer {};
			class database_saveStatic {};
			class database_saveWreck {};
			class database_showID {};
			class database_writeDatabase {};
		};
		class eden {
			file = "functions\STNE\eden";
			class eden_getClassLoadouts {};
			class eden_getClassNames {};
			class eden_getLoadouts {};
		};
		class event {
			file = "functions\STNE\event";
			class event_addEvents {preInit = 1;};
		};
		class init {
			file = "functions\STNE\init";
			class init_setLoadout {};
		};
		class save {
			file = "functions\STNE\save";
			class save_getCargo {};
			class save_getCargoBackpack {};
			class save_getCargoItem {};
			class save_getCargoMagazine {};
			class save_getCargoWeapon {};
			class save_getSQF {};
		};
		class server {
			file = "functions\STNE\server";
			class server_addFortifyACE {};
			class server_addGroup {};
			class server_addGroupCustom {};
			class server_getMods {preInit = 1;};
			class server_getVariables {};
			class server_runUnitPlay {};
			class server_setDynamicSimulation {};
			class server_setViewDistance {};
			class server_toggleDynamicSimulation {};
		};
		class zeus {
			file = "functions\STNE\zeus";
			class zeus_addActions {};
			class zeus_addModules {};
			class zeus_addPlayers {};
			class zeus_addZeus {};
		};
	};
//};