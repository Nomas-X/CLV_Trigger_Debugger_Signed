if !(hasinterface) exitwith {};
/*
	Description:
		Init script, start on postinit in any pc with interface

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
addMissionEventHandler ["EachFrame",{
    if (
        !(isnull (findDisplay 312 displayctrl 50)) &&
        isnull (finddisplay 312 displayCtrl 13140)
    ) then {
      [] call clv_fnc_TD_MenuZeus;
      [] call clv_fnc_TD_triggerDraw;
    };
}];
