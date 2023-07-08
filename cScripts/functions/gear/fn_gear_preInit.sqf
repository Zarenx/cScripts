#include "..\script_component.hpp";
/*
 * Author: BaerMitUmlaut, CPL.Brostrom.A
 * This function runs on preInit and setup the gear system using CBA addClassEventHandler.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Example:
 * call cScripts_fnc_gear_postInit
 *
 */

GVAR(Gear) = false;

EGVAR(gear,groupIDsSynched) = false;
EGVAR(gear,playerLoadoutGiven) = false;

if (isClass (missionConfigFile >> "CfgLoadouts")) then {
    ["CAManBase", "InitPost", {
        params ["_unit"];
        if (!local _unit) exitWith {
            if (_unit == player) then {
                ["Non-local player in initPost", "Debug"] call FUNC(warning);
            };
        };

        if (_unit == player && {!EGVAR(gear,playerLoadoutGiven)}) then {
            EGVAR(RADIO,TFAR) = false;
            EGVAR(gear,playerLoadoutGiven) = true;
            private _loadout = [_unit] call EFUNC(gear,selectLoadout);
            [_unit, _loadout] call EFUNC(gear,applyLoadout);
        } else {
            if (
                _unit in switchableUnits
                && {typeOf _unit != "HeadlessClient_F"}
            ) then {
                private _loadout = [_unit] call EFUNC(gear,selectLoadout);
                [_unit, _loadout] call EFUNC(gear,applyLoadout);
            };
        };
    }] call CBA_fnc_addClassEventHandler;

    ["CAManBase", "Respawn", {
        params ["_unit"];
        if (_unit == player) then {
            EGVAR(RADIO,TFAR) = false;
            if (_unit call EFUNC(gear,hasSavedLoadout)) then {
                _unit call EFUNC(gear,loadLoadout);
            } else {
                private _loadout = [_unit] call EFUNC(gear,selectLoadout);
                [_unit, _loadout] call EFUNC(gear,applyLoadout);
            };
        };
    }] call CBA_fnc_addClassEventHandler;

    ["CAManBase", "Local", {
        params ["_unit"];
        if (_unit == player && {local _unit} && {!EGVAR(gear,playerLoadoutGiven)}) then {
            EGVAR(RADIO,TFAR) = false;
            EGVAR(gear,playerLoadoutGiven) = true;
            private _loadout = [_unit] call EFUNC(gear,selectLoadout);
            [_unit, _loadout] call EFUNC(gear,applyLoadout);
        };
    }] call CBA_fnc_addClassEventHandler;
};

GVAR(Gear) = true;
