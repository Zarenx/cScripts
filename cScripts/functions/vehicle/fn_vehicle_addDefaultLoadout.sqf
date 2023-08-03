#include "..\script_component.hpp";
/*
 * Author: CPL.Brostrom.A
 * This function apply a default loadouts to a selected vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Example:
 * ["vic"] call cScripts_fnc_vehicle_addDefaultLoadout
 */

params [["_vehicle", objNull, [objNull]]];

if (!isServer) exitWith {};
if (isNull _vehicle) then {["Vehicle is null and not defined", "Vehicle Default Pylon"] call FUNC(error);};
if (_vehicle iskindOf "man") exitWith {};
if (!isNil{_vehicle getVariable QEGVAR(Vehicle,PylonApplyed)}) exitWith {[format["Vehicle loadouts already applied for %1.", _vehicle], "Vehicle Default Pylon"] call FUNC(warning);};
if (!(_vehicle call FUNC(isValidFaction))) exitWith {};

#ifdef DEBUG_MODE
    [formatText["Applying vehicle loadout to %1.", _vehicle], "Vehicle Default Pylon"] call FUNC(info);
#endif

// Default pylon applied
private _pylon = [];

if (_vehicle iskindOf "rhsusf_m1a1tank_base") then {
    _pylon = ["rhsusf_m1a1tank_base", "default"] call EFUNC(vehicle,getPylon);
    [_vehicle, "default", _pylon] call EFUNC(vehicle,applyLoadout);
};

if (_vehicle iskindOf "I_APC_Wheeled_03_cannon_F" && !(_vehicle isKindOf "cav_dragoon_unarmed_base_F")) then {
    _pylon = ["I_APC_Wheeled_03_cannon_F", "default"] call EFUNC(vehicle,getPylon);
    [_vehicle, "default", _pylon] call EFUNC(vehicle,applyLoadout);
};

_vehicle setVariable [QEGVAR(Vehicle,PylonApplyed), true, true];