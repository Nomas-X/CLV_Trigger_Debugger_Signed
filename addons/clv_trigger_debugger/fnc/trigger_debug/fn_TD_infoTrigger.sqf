
/*
	Description:
		Gives information about the trigger

	parameters:
		trigger (object)

	Rrturn:
	 nothing

	Author:
		FlyingTarta

	Date:
		25/8/2021

	Licence:
		GNU General Public License

*/

params ["_trigger"];

//_trigger = allMissionObjects "EmptyDetector" #0;
_triggerActivated = triggerActivated _trigger;
_activation = triggeractivation _trigger;
_triggerType = triggertype _trigger;
_statements = triggerstatements _trigger;
_listT = list _trigger;


_text = [
  linebreak,
  parsetext "<t size='1.2'><t underline='1'><t color='#FF9501'><t font='PuristaBold'>TRIGGER INFO:</t></t></t></t>",linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'><t color='#FF9501'>Activated: </t></t>", str(_triggerActivated),linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'><t color='#FF9501'>Trigger Activation:</t></t>",linebreak,
  parsetext format["  <t font='PuristaBold'>by:</t>            %1",_activation#0],linebreak,
  parsetext format["  <t font='PuristaBold'>type:</t>        %1",_activation#1],linebreak,
  parsetext format["  <t font='PuristaBold'>Repeat:</t>   %1",_activation#2],linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'><t color='#FF9501'>Statements:</t></t>",linebreak,
  parsetext"<t font='PuristaBold'>Condition:</t>",linebreak,
  format["%1",_statements#0],linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'>Activation code:</t>",linebreak,
  format["%1",_statements#1],linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'>De-activation code:</t>",linebreak,
  format["%1",_statements#2],linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'><t color='#FF9501'>Trigger Type</t></t>:  ",_triggerType,
  linebreak,
  linebreak,
  parsetext"<t font='PuristaBold'><t color='#FF9501'>Trigger Detecting:</t></t>",linebreak,
  str(_listT)
];

_btn = findDisplay 312 ctrlcreate ["ctrlStructuredText",80000];
_boton = [getmouseposition #0,getmouseposition #1,0.24,1.5];

_btn ctrlSetPosition _boton;//[( _pos #0 + 0.12) , ((_pos #1) + 1),0.24,2];
_btn ctrlSetBackgroundColor [0,0,0,0.5];
_btn ctrlSetStructuredText composetext _text;
_btn ctrlCommit 0;


_eh = (findDisplay 312) displayAddEventHandler ["MouseButtonDown",{
    [] spawn {
      ctrlDelete (findDisplay 312 displayctrl 80000);
    };
}];

waituntil {isnull (findDisplay 312 displayctrl 80000)};
(findDisplay 312) displayRemoveEventHandler ["MouseButtonDown",_eh];
