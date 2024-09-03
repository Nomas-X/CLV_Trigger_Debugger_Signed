/*
  Decripcion:
    Changes the var to its opossite on button push

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

_isTrue = localnamespace getvariable ["clv_MostrarTriggerDebug",false];

if (_isTrue) then {
  localNamespace setvariable ["clv_MostrarTriggerDebug",false];
}else{
  localNamespace setvariable ["clv_MostrarTriggerDebug",true];
  _boton = finddisplay 312 displayCtrl 13140;
};
