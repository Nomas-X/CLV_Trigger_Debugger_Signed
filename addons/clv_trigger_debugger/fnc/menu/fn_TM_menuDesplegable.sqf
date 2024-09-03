/*
	Description:
		Menu desplegable 100% escalable

	parameters:
		array de textos estructurado, para las opciones

	Rrturn:
	 Index de opcion elegida

	Author:
		FlyingTarta

	Date:
		25/8/2021

	Licence:
		GNU General Public License

*/

private _boton = [getmouseposition #0-0.2,getmouseposition #1,0.20,0.040];

private _curatorDisplay = findDisplay 312;

if (!isnull (finddisplay 312 displayCtrl 20000)) exitwith {-1};

params [ ["_opciones",[]] ];

//_opciones = ["op1","op2","op3","op4"];

localNamespace setvariable ["CLV_MD_OUTPUT",-1];

botones = [];
{
  _displaynum = 20000 + _forEachIndex;


  _btn = _curatorDisplay ctrlcreate ["RscButtonMenu",_displaynum];

  botones pushbackunique _btn;
  _nuevoY = 0.043*_forEachIndex;
  _boton set [1,getmouseposition #1 + _nuevoY];
  _btn ctrlSetPosition _boton;
  _btn ctrlSetStructuredText _x;
  _btn ctrlSetActiveColor [0,0.4,0.93,1];
  _btn ctrlCommit 0;

  _btn ctrlAddEventHandler ["ButtonClick",
  {
    _out = parseNumber ((str(_this select 0) splitString "#") select 1) - 20000;
    localNamespace setvariable ["CLV_MD_OUTPUT",_out];
    [] spawn {
      botones apply {ctrldelete _x};
      botones = [];
    };
  }];
}foreach _opciones;

// sale si se clickea fuera
_eh = (findDisplay 312) displayAddEventHandler ["MouseButtonDown",{
    [] spawn {
      uisleep 0.15;
      if ((localNamespace getvariable "CLV_MD_OUTPUT") isequalto -1) then {
        localNamespace setvariable ["CLV_MD_OUTPUT",( (count(botones) - 1))];
        botones apply {ctrldelete _x};
        botones = [];
      };
    };
}];

waituntil {
   (localNamespace getvariable "CLV_MD_OUTPUT") isnotequalto -1 && isnull (finddisplay 312 displayCtrl 2001)
 };
(findDisplay 312) displayRemoveEventHandler ["MouseButtonDown",_eh];
(localNamespace getvariable "CLV_MD_OUTPUT")
