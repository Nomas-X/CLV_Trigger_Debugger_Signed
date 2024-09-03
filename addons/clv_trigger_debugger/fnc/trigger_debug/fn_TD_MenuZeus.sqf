/*
	Description:
		Adds Button to open the tool

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

#include "\a3\ui_f\hpp\definedikcodes.inc"
_curatorDisplay = findDisplay 312;
([] call BIS_fnc_GUIGrid) params ["", "", "_GUI_GRID_W", "_GUI_GRID_H"];
_GUI_GRID_W = _GUI_GRID_W / 40;
_GUI_GRID_H = _GUI_GRID_H / 25;
_btn = _curatorDisplay ctrlCreate ["RscButton", 13140];
_btn ctrlSetPosition [
	safezoneX + safezoneW - 23.6 * _GUI_GRID_W,
	safeZoneY + 1.6 * _GUI_GRID_H,
	11 * _GUI_GRID_W,
	1 * _GUI_GRID_H
];
_btn ctrlSetTooltip "Show Triggers on zeus map";
_btn ctrlSetText "Trigger Debug BETA!";
_btn ctrlCommit 0;

_btn ctrlAddEventHandler ["ButtonClick",
{
	 [] call clv_fnc_TD_zeusButton;
}];

_curatorDisplay displayAddEventHandler ["KeyDown",{
	params ["_curatorDisplay", "_key"];
	if (_key in actionkeys 'curatorToggleInterface') then {
		_screenshotMode = uiNamespace getVariable ["RscDisplayCurator_screenshotMode", false];
		_btn = _curatorDisplay displayCtrl 13140;
		_btn ctrlEnable _screenshotMode;
		_fade = [0,1] select !_screenshotMode;
		_btn ctrlSetFade _fade;
		_btn ctrlCommit 0.1;
	};
}];
