/*
	Description:
		Draws triggers on the map

	parameters:
		none

	Rrturn:
	 nothing

	Author:
		FlyingTarta

	Date:
		25/8/2021

	Licence:
		GNU General Public License

*/
private _mapa = findDisplay 312 displayCtrl 50;
botones = [];
_mapa ctrlAddEventHandler ["Draw",{
	_map = _this select 0;
	if !(visibleMap) exitwith {};
	if (localnamespace getvariable ["clv_MostrarTriggerDebug",false]) then {
		_triggers = allMissionObjects "EmptyDetector";
		{
			_trigger = _x;
			(triggerarea _trigger) params ["_x","_y","_dir","_rectangle","_z"] ;
			//_color = [1,0,0,0.5];
			_fill = "#(rgb,8,8,3)color(1,0,0,0.3)";
			if !(triggerActivation _trigger #2) then {
				if (triggerActivated _trigger || _trigger getvariable ["activado",false]) then {
					//_color = [0,1,0,0.3];
					_fill = "#(rgb,8,8,3)color(0,0,0,0.3)";
				};
			};
			if (_trigger getvariable ["selected",false]) then{
				//_color = [1,1,1,0.5];
				_fill = "#(rgb,8,8,3)color(1,0.58,0,0.3)";
			};

			//dibujamos el icono - Draw trigger icon
			_map DrawIcon ["iconLogic",[0,0,1,0.8],getpos _trigger,3/ctrlmapscale _map,3/ctrlmapscale _map,0,triggertext _trigger];

			_SyncObj = synchronizedObjects _trigger;
			if (_SyncObj isnotequalto []) then {
				{
					_module = _x;
					if !("Module" in (typeof _module)) then {break}; //si no es un modulo sale

					_map DrawIcon [gettext (configFile >> "CfgVehicles" >> typeof _x >> "icon"),[0,0,1,0.8],getpos _x,3/ctrlmapscale _map,3/ctrlmapscale _map,0,gettext (configFile >> "CfgVehicles" >> typeof _x >> "displayName") ];
					_map drawLine [getpos _trigger,getpos _x,[0,0,1,0.8]];
					{
							_map drawLine [getpos _module,getpos _x,[0,1,1,0.7]];
							_map DrawIcon ["\a3\ui_f\data\IGUI\Cfg\SquadRadar\SquadRadarOtherGroupUnit_ca",[0,0,1,0.8],getpos _x,2/ctrlmapscale _map,2/ctrlmapscale _map,0];
					}foreach (synchronizedObjects _x);
				}foreach _SyncObj
			};

			if !(_rectangle) then {
				_map drawEllipse [
						getpos _trigger, //posicion
						_x, //ancho x
						_y, // acncho y
						_dir, //direccion
						[1,1,1,1], //color
						_fill
					];
			}else{
				_map drawRectangle [
					getpos _trigger, //posicion
					_x, //ancho x
					_y, // acncho y
					_dir, //direccion
					[1,1,1,1], //color
					_fill//"#(rgb,8,8,3)color(1,0,0,1)" //textura
				];
			};
		}foreach _triggers;

	};
}];


(findDisplay 312) displayAddEventHandler ["MouseButtonDown",{
		_this spawn {

	    params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
			if !(visibleMap) exitwith {};
			//click derecho 1
	    if (localnamespace getvariable ["clv_MostrarTriggerDebug",false]) then {

	      _pos = (finddisplay 312 displayCtrl 50 ) ctrlMapScreenToWorld [_xPos,_yPos];
	      _trigger = ((allMissionObjects "EmptyDetector") select {_pos inarea _x });
				if (_trigger isequalto [] || _button isequalto 0) exitwith {};
				_trigger = _trigger #0;
				//if ( triggerActivated _trigger || _trigger getvariable ["activado",false] ) exitwith {};
				_trigger setvariable ["selected",true];

				_opciones = [
					composeText [image "clv_trigger_debugger\gui\img\talk_ca.paa",parsetext "<t font='PuristaSemibold'> | Info</t>"],
					composeText [image "clv_trigger_debugger\gui\img\ico_ON_ca.paa",parsetext "<t font='PuristaSemibold'> | Activate</t>"],
					composeText [image "clv_trigger_debugger\gui\img\icon_exit_cross_ca.paa",parsetext "<t font='PuristaSemibold'> | Delete</t>"],
					composeText [image "clv_trigger_debugger\gui\img\icon_exit_ca.paa",parsetext "<t font='PuristaSemibold'> | Exit</t>"]
				];

				private _resp = [_opciones] call clv_fnc_TM_menuDesplegable;

				if (_resp isequalto 0 ) then {
					[_trigger] call clv_fnc_TD_infoTrigger;
					_trigger setvariable ["selected",false];
				};

				if (_resp isequalto 1 ) then {//Activar trigger
					if ( (triggerActivated _trigger || _trigger getvariable ["activado",false]) && !(triggerActivation _trigger #2) ) exitwith {};
					_resp = ["Are you sure you want to activate this trigger ", "ACTIVATE", true,true,findDisplay 312,true] call BIS_fnc_guiMessage;
					if (_resp) then {
						_statement = triggerStatements _trigger;
						_statement set [0,"true"];
						[_trigger,_statement] remoteexec ["settriggerstatements",0,true];
						if !(triggerActivation _trigger #2) then {
							_trigger setvariable ["activado",true,true];
						};
						//_trigger settriggerstatements _statement;
					};
					_trigger setvariable ["selected",false];
				};

				if (_resp isequalto 2 ) then {
					_resp = ["Are you sure you wan to DELETE this trigger? ", "DELETE", true,true,findDisplay 312,true] call BIS_fnc_guiMessage;
					if (_resp) then {
						deletevehicle _trigger;
					};
					_trigger setvariable ["selected",false];
				};

				if (_resp isequalto 3 ) then {};

				_trigger setvariable ["selected",false];
	    };
		};
}];
