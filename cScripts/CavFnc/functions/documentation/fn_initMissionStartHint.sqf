/*
 * Author: CPL.Brostrom.A 
 * This adds a couple of hints at start for all players.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Example:
 * [this] call cScripts_fnc_initMainSandbox
 */

waitUntil {!isNull player && player == player};
if (!isServer) exitWith {};

#include "..\script_component.hpp";

_title1  = "<t color='#ff0000' size='1.2' shadow='1' shadowColor='#000000' align='center'>RED LIGHT!</t><br />";
_title2  = "<t color='#00cd00' size='1.2' shadow='1' shadowColor='#000000' align='center'>GREEN LIGHT!</t><br />";
_image  = "<br /><br /><img size='5' image='cScripts\Data\Images\7CAV_LOGO_00.paa' align='center'/><br /><br />";
_text0 = "<t font='Zeppelin33'>Hold coms and Stand still.</t><br /><br />";
_text1 = "While waiting you can always read the <t color='#ffc61a'>OPORD</t> and <t color='#ffc61a'>SOI</t> again. Cause you have of cause read it already.<br />";
_text2 = "If you need to call in <t color='#ffc61a'>support</t> or need other kind of help during the mission see the topic <t color='#ffc61a'>7th Cavalry</t> or <t color='#ffc61a'>Radio Reports</t> on the map screen. You can also see your assigned loudout there.<br />";
_text3a = "<t font='Zeppelin33'>You may now move!</t>";
_text3b = "<t font='Zeppelin33'>Have fun!</t>";

sleep 1;
parseText (_title1 + _text0 + _text1) remoteExec ["hint"];
sleep 12;
parseText (_title1 + _text0 + _text2) remoteExec ["hint"];
sleep 14;
//parseText (_title1 + _text0) remoteExec ["hint"];
//sleep 5;
parseText (_title2 + _text3a + _image + _text3b) remoteExec ["hint"];
sleep 10;
"" remoteExec ["hint"];
sleep 60;
"" remoteExec ["hint"]; // Fail safe in case people get the hint stuck