class CfgPatches{
	class clv_trigger_debugger
	{
		// Meta information for editor
		name = "Trigger debugger";
		author = "[calaveras] FlyingTarta";
		// Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game. Note: was disabled on purpose some time late into Arma 2: OA.
		requiredVersion = 2.02;
		// Required addons, used for setting load order.
		// When any of the addons is missing, pop-up warning will appear when launching the game.
		requiredAddons[] = {};
		// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
		units[] = {};
		// List of weapons (CfgWeapons classes) contained in the addon.
		weapons[] = {};
	};
};

class CfgFunctions {
	class clv {
		//#include "fnc\cfgfunctions.hpp"
		class trigger_debug
		{
			file = "clv_trigger_debugger\fnc\trigger_debug";
			class TD_init { PostInit = 1;};
			class TD_triggerDraw {};
			class TD_menuZeus		 {};
			class TD_ZeusButton	 {};
			class TD_infoTrigger {};
		};
		class TartaMenu {
			file = "clv_trigger_debugger\fnc\menu";
			class TM_menuDesplegable {};
		};
	};
};