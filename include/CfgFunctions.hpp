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
		class arsenal {
			file = "functions\STNE\arsenal";
			class arsenal_addLoadouts {};
			class arsenal_addMedical {};
			class arsenal_addSandbox {};
			class arsenal_addSOG {};
		};
		class briefing {
			file = "functions\STNE\briefing";
			class briefing_addText {};
			class briefing_getLine {};
		};
		class eden {
			file = "functions\STNE\eden";
			class eden_getClassNames {};
			class eden_getLoadouts {};
		};
		class event {
			file = "functions\STNE\event";
			class event_addEvents {preInit = 1;};
		};
		class server {
			file = "functions\STNE\server";
			class server_addGroup {};
			class server_addGroupCustom {};
			class server_getMods {preInit = 1;};
			class server_getVariables {};
			class server_setDynamicSimulation {};
			class server_setViewDistance {};
			class server_toggleDynamicSimulation {};
		};
		class zeus {
			file = "functions\STNE\zeus";
			class zeus_addModules {};
			class zeus_addPlayers {};
			class zeus_addZeus {};
		};
	};
//};