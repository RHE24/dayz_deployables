scriptName "Functions\misc\fn_selfActions.sqf";
/***********************************************************
	ADD ACTIONS FOR SELF
	- Function
	- [] call fnc_usec_selfActions;
************************************************************/
private["_isStash","_vehicle","_inVehicle","_bag","_classbag","_isWater","_hasAntiB","_hasFuelE","_hasFuel5","_hasbottleitem","_hastinitem","_hasKnife","_hasToolbox","_hasTent","_onLadder","_nearLight","_canPickLight","_canDo","_text","_isHarvested","_isVehicle","_isVehicletype","_isMan","_ownerID","_isAnimal","_isDog","_isZombie","_isDestructable","_isTent","_isFuel","_isAlive","_canmove","_rawmeat","_hasRawMeat","_allFixed","_hitpoints","_damage","_part","_cmpt","_damagePercent","_color","_string","_handle","_dogHandle","_lieDown","_warn","_dog","_speed"];

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_bag = unitBackpack player;
_classbag = typeOf _bag;
_isWater = (surfaceIsWater (position player)) or dayz_isSwimming;
_hasAntiB = "ItemAntibiotic" in magazines player;
_hasFuelE20 = "ItemJerrycanEmpty" in magazines player;
_hasFuelE5 = "ItemFuelcanEmpty" in magazines player;
//boiled Water
_hasbottleitem = "ItemWaterbottle" in magazines player;
_hastinitem = false;
{
    if (_x in magazines player) then {
        _hastinitem = true;
    };

} forEach boil_tin_cans;


_hasKnife = "ItemKnife" in items player;
_hasMatches = "ItemMatchbox" in items player;
_hasToolbox = "ItemToolbox" in items player;
//_hasTent = "ItemTent" in items player;
_onLadder = (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_nearLight = nearestObject [player,"LitObject"];
_canPickLight = false;

if (!isNull _nearLight) then {
	if (_nearLight distance player < 4) then {
		_canPickLight = isNull (_nearLight getVariable ["owner",objNull]);
	};
};
_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);

//begin deployable bike
	

    if((speed player <= 1) && cursorTarget isKindOf "CSJ_GyroC" && _canDo) then {
    if ((s_player_deploybike6 < 0) && (isNull (driver cursorTarget))) then {
                    s_player_deploybike6 = player addaction[("<t color=""#007ab7"">" + ("Repack Gyrocopter") +"</t>"),"custom\repack_gyrocopter.sqf",cursorTarget,5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike6;
            s_player_deploybike6 = -1;
    };
     
    if((speed player <= 1) && cursorTarget isKindOf "TT650_Civ" && _canDo) then {
    if ((s_player_deploybike5 < 0) && (isNull (driver cursorTarget))) then {
                    s_player_deploybike5 = player addaction[("<t color=""#007ab7"">" + ("Upgrade to Gyrocopter") +"</t>"),"custom\upgrade_motorbike.sqf",cursorTarget,5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike5;
            s_player_deploybike5 = -1;
    };
     
    if((speed player <= 1) && cursorTarget isKindOf "TT650_Civ" && _canDo) then {
    if ((s_player_deploybike4 < 0) && (isNull (driver cursorTarget))) then {
                    s_player_deploybike4 = player addaction[("<t color=""#007ab7"">" + ("Repack Motorcycle") +"</t>"),"custom\repack_motorbike.sqf",cursorTarget,5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike4;
            s_player_deploybike4 = -1;
    };
     
    if((speed player <= 1) && cursorTarget isKindOf "Old_bike_TK_CIV_EP1" && _canDo) then {
    if ((s_player_deploybike3 < 0) && (isNull (driver cursorTarget))) then {
                    s_player_deploybike3 = player addaction[("<t color=""#007ab7"">" + ("Upgrade to Motorcycle") +"</t>"),"custom\upgrade_bike.sqf",cursorTarget,5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike3;
            s_player_deploybike3 = -1;
    };
     
    if((speed player <= 1) && cursorTarget isKindOf "Old_bike_TK_CIV_EP1" && _canDo) then {
    if ((s_player_deploybike2 < 0) && (isNull (driver cursorTarget))) then {
                    s_player_deploybike2 = player addaction[("<t color=""#007ab7"">" + ("Repack Bike (Recover 1 Toolbox)") +"</t>"),"custom\repack_bike.sqf",cursorTarget,5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike2;
            s_player_deploybike2 = -1;
    };
     
    if((speed player <= 1) && _hasToolbox && _canDo) then {
            if (s_player_deploybike < 0) then {
                    s_player_deploybike = player addaction[("<t color=""#007ab7"">" + ("Deploy Bike (Consume 1 Toolbox)") +"</t>"),"custom\deploy_bike.sqf","",5,false,true,"", ""];
            };
    } else {
            player removeAction s_player_deploybike;
            s_player_deploybike = -1;
    };

//end deployable bike
//Krixes Self Bloodbag 
	_mags = magazines player;
	
	// Krixes Self Bloodbag
	if ("ItemBloodbag" in _mags) then {
		hasBagItem = true;
	} else { hasBagItem = false;};
	if((speed player <= 1) && hasBagItem && _canDo) then {
		if (s_player_selfBloodbag < 0) then {
			s_player_selfBloodbag = player addaction[("<t color=""#c70000"">" + ("Self Bloodbag") +"</t>"),"\z\addons\dayz_code\actions\player_selfbloodbag.sqf","",5,false,true,"", ""];
		};
	} else {
		player removeAction s_player_selfBloodbag;
		s_player_selfBloodbag = -1;
	};

//Grab Flare
if (_canPickLight and !dayz_hasLight) then {
	if (s_player_grabflare < 0) then {
		_text = getText (configFile >> "CfgAmmo" >> (typeOf _nearLight) >> "displayName");
		s_player_grabflare = player addAction [format[localize "str_actions_medical_15",_text], "\z\addons\dayz_code\actions\flare_pickup.sqf",_nearLight, 1, false, true, "", ""];
		s_player_removeflare = player addAction [format[localize "str_actions_medical_17",_text], "\z\addons\dayz_code\actions\flare_remove.sqf",_nearLight, 1, false, true, "", ""];
	};
} else {
	player removeAction s_player_grabflare;
	player removeAction s_player_removeflare;
	s_player_grabflare = -1;
	s_player_removeflare = -1;
};

if (!isNull cursorTarget and !_inVehicle and (player distance cursorTarget < 4)) then { //Has some kind of target
	_isHarvested = cursorTarget getVariable["meatHarvested",false];
	_isVehicle = cursorTarget isKindOf "AllVehicles";
	_isVehicletype = typeOf cursorTarget in ["ATV_US_EP1","ATV_CZ_EP1"];
	_isMan = cursorTarget isKindOf "Man";
	_ownerID = cursorTarget getVariable ["characterID","0"];
	_isAnimal = cursorTarget isKindOf "Animal";
	_isDog = (cursorTarget isKindOf "DZ_Pastor" || cursorTarget isKindOf "DZ_Fin");
	_isZombie = cursorTarget isKindOf "zZombie_base";
	_isDestructable = cursorTarget isKindOf "BuiltItems";
	_isTent = cursorTarget isKindOf "TentStorage";
	_isStash = cursorTarget isKindOf "StashSmall";
	_isMediumStash = cursorTarget isKindOf "StashMedium";
	_isFuel = false;
	_hasFuel20 = "ItemJerrycan" in magazines player;
	_hasFuel5 = "ItemFuelcan" in magazines player;
	_isAlive = alive cursorTarget;
	_canmove = canmove cursorTarget;
	_text = getText (configFile >> "CfgVehicles" >> typeOf cursorTarget >> "displayName");

	_rawmeat = meatraw;
	_hasRawMeat = false;
		{
			if (_x in magazines player) then {
				_hasRawMeat = true;
			};
		} forEach _rawmeat;


	if (_hasFuelE20 or _hasFuelE5) then {
		_isFuel = (cursorTarget isKindOf "Land_Ind_TankSmall") or (cursorTarget isKindOf "Land_fuel_tank_big") or (cursorTarget isKindOf "Land_fuel_tank_stairs") or (cursorTarget isKindOf "Land_wagon_tanker");
	};
	//diag_log ("OWNERID = " + _ownerID + " CHARID = " + dayz_characterID + " " + str(_ownerID == dayz_characterID));

	//Allow player to delete objects
	if(_isDestructable and _hasToolbox and _canDo) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "\z\addons\dayz_code\actions\remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};

	//Allow player to force save
	if((_isVehicle or _isTent or _isStash or _isMediumStash) and _canDo and !_isMan and (damage cursorTarget < 1)) then {
		if (s_player_forceSave < 0) then {
			s_player_forceSave = player addAction [format[localize "str_actions_save",_text], "\z\addons\dayz_code\actions\forcesave.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_forceSave;
		s_player_forceSave = -1;
	};

	//flip vehicle
	if ((_isVehicletype) and !_canmove and _isAlive and (player distance cursorTarget >= 2) and (count (crew cursorTarget))== 0 and ((vectorUp cursorTarget) select 2) < 0.5) then {
		if (s_player_flipveh < 0) then {
			s_player_flipveh = player addAction [format[localize "str_actions_flipveh",_text], "\z\addons\dayz_code\actions\player_flipvehicle.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_flipveh;
		s_player_flipveh = -1;
	};

	//Allow player to fill Fuel can
	if((_hasFuelE20 or _hasFuelE5) and _isFuel and _canDo and !a_player_jerryfilling) then {
		if (s_player_fillfuel < 0) then {
			s_player_fillfuel = player addAction [localize "str_actions_self_10", "\z\addons\dayz_code\actions\jerry_fill.sqf",[], 1, false, true, "", ""];
		};
	} else {
		player removeAction s_player_fillfuel;
		s_player_fillfuel = -1;
	};

	//Auto Refuel
	_gasolineras = nearestObjects[player,["Land_Ind_TankSmall","Land_fuel_tank_big","Land_fuel_tank_stairs","Land_wagon_tanker"],10];
	_esGasolinera=(count _gasolineras) > 0;
    if((dayz_myCursorTarget != cursorTarget) and _isVehicle and  _esGasolinera and _canDo and !_isMan) then {
	_vehicle = cursorTarget;
	{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
	dayz_myCursorTarget = _vehicle;
	_string = "<t color='#ffff00'>Auto Refuel</t>"; 
	_handle = dayz_myCursorTarget addAction [_string, "\z\addons\dayz_code\actions\refuel_auto.sqf",[_vehicle], 0, false, true, "",""];
	s_player_repairActions set [count s_player_repairActions,_handle];                
};

	//Allow player to fill vehilce 20L
	if(_hasFuel20 and _canDo and _isVehicle and (fuel cursorTarget < 1)) then {
		if (s_player_fillfuel20 < 0) then {
			s_player_fillfuel20 = player addAction [format[localize "str_actions_medical_10"+" with 20L",_text], "\z\addons\dayz_code\actions\refuel.sqf",["ItemJerrycan"], 0, true, true, "", "'ItemJerrycan' in magazines player"];
		};
	} else {
		player removeAction s_player_fillfuel20;
		s_player_fillfuel20 = -1;
	};

	//Allow player to fill vehilce 5L
	if(_hasFuel5 and _canDo and _isVehicle and (fuel cursorTarget < 1)) then {
		if (s_player_fillfuel5 < 0) then {
			s_player_fillfuel5 = player addAction [format[localize "str_actions_medical_10"+" with 5L",_text], "\z\addons\dayz_code\actions\refuel.sqf",["ItemFuelcan"], 0, true, true, "", "'ItemFuelcan' in magazines player"];
		};
	} else {
		player removeAction s_player_fillfuel5;
		s_player_fillfuel5 = -1;
	};

	//Harvested
	if (!alive cursorTarget and _isAnimal and _hasKnife and !_isHarvested and _canDo) then {
		if (s_player_butcher < 0) then {
			s_player_butcher = player addAction [localize "str_actions_self_04", "\z\addons\dayz_code\actions\gather_meat.sqf",cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_butcher;
		s_player_butcher = -1;
	};

	//Fireplace Actions check
	if (inflamed cursorTarget and _hasRawMeat and _canDo and !a_player_cooking) then {
		if (s_player_cook < 0) then {
			s_player_cook = player addAction [localize "str_actions_self_05", "\z\addons\dayz_code\actions\cook.sqf",cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_cook;
		s_player_cook = -1;
	};
	if (inflamed cursorTarget and (_hasbottleitem and _hastinitem) and _canDo and !a_player_boil) then {
		if (s_player_boil < 0) then {
			s_player_boil = player addAction [localize "str_actions_boilwater", "\z\addons\dayz_code\actions\boil.sqf",cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_boil;
		s_player_boil = -1;
	};

	if(cursorTarget == dayz_hasFire and _canDo) then {
		if ((s_player_fireout < 0) and !(inflamed cursorTarget) and (player distance cursorTarget < 3)) then {
			s_player_fireout = player addAction [localize "str_actions_self_06", "\z\addons\dayz_code\actions\fire_pack.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_fireout;
		s_player_fireout = -1;
	};
	
	//DANCE
    if (inflamed cursorTarget and _canDo) then {
            if (s_player_dance < 0) then {
            s_player_dance = player addAction ["Dance","\z\addons\dayz_code\actions\dance.sqf",cursorTarget, 0, false, true, "",""];
        };
    } else {
        player removeAction s_player_dance;
        s_player_dance = -1;
    };
	
	 //Allow player to set tent on fire
    if(_isTent and _hasMatches and _canDo and !_isMan) then {
        if (s_player_igniteTent < 0) then {
            s_player_igniteTent = player addAction [format["Ignite Tent"], "\z\addons\dayz_code\actions\tent_ignite.sqf",cursorTarget, 1, true, true, "", ""];
        };
    } else {
        player removeAction s_player_igniteTent;
        s_player_igniteTent = -1;
    };

	//Packing my tent
	if(cursorTarget isKindOf "TentStoragOWe" and _canDo and _ownerID == dayz_characterID) then {
		if ((s_player_packtent < 0) and (player distance cursorTarget < 3)) then {
			s_player_packtent = player addAction [localize "str_actions_self_07", "\z\addons\dayz_code\actions\tent_pack.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_packtent;
		s_player_packtent = -1;
		};

	//Sleep
	if(cursorTarget isKindOf "TentStorage" and _canDo and _ownerID == dayz_characterID) then {
		if ((s_player_sleep < 0) and (player distance cursorTarget < 3)) then {
			s_player_sleep = player addAction [localize "str_actions_self_sleep", "\z\addons\dayz_code\actions\player_sleep.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_sleep;
		s_player_sleep = -1;
	};
	
	
	// Remove Parts from Vehicles - By SilverShot.
	if( !_isMan and _canDo and _hasToolbox and (silver_myCursorTarget != cursorTarget) and cursorTarget isKindOf "AllVehicles" and (getDammage cursorTarget < 0.95) ) then {
	_vehicle = cursorTarget;
	_invalidVehicle = (_vehicle isKindOf "Motorcycle") or (_vehicle isKindOf "Tractor"); //or (_vehicle isKindOf "ATV_US_EP1") or (_vehicle isKindOf "ATV_CZ_EP1");
	if( !_invalidVehicle ) then {
	{silver_myCursorTarget removeAction _x} forEach s_player_removeActions;
	s_player_removeActions = [];
	silver_myCursorTarget = _vehicle;
	 
	_hitpoints = _vehicle call vehicle_getHitpoints;
	 
	{
	_damage = [_vehicle,_x] call object_getHit;
	 
	if( _damage < 0.15 ) then {
	 
	//change "HitPart" to " - Part" rather than complicated string replace
	_cmpt = toArray (_x);
	_cmpt set [0,20];
	_cmpt set [1,toArray ("-") select 0];
	_cmpt set [2,20];
	_cmpt = toString _cmpt;
	 
	_skip = true;
	if( _skip and _x == "HitFuel" ) then { _skip = false; _part = "PartFueltank"; _cmpt = _cmpt + "tank"};
	if( _skip and _x == "HitEngine" ) then { _skip = false; _part = "PartEngine"; };
	if( _skip and _x == "HitLFWheel" ) then { _skip = false; _part = "PartWheel"; };
	if( _skip and _x == "HitRFWheel" ) then { _skip = false; _part = "PartWheel"; };
	if( _skip and _x == "HitLBWheel" ) then { _skip = false; _part = "PartWheel"; };
	if( _skip and _x == "HitRBWheel" ) then { _skip = false; _part = "PartWheel"; };
	if( _skip and _x == "HitGlass1" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitGlass2" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitGlass3" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitGlass4" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitGlass5" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitGlass6" ) then { _skip = false; _part = "PartGlass"; };
	if( _skip and _x == "HitHRotor" ) then { _skip = false; _part = "PartVRotor"; };
	 
	if (!_skip ) then {
	_string = format["<t color='#0096ff'>Remove%1</t>",_cmpt,_color]; //Remove - Part
	_handle = silver_myCursorTarget addAction [_string, "\z\addons\dayz_code\actions\ss_remove.sqf",[_vehicle,_part,_x], 0, false, true, "",""];
	s_player_removeActions set [count s_player_removeActions,_handle];
	};
	};
	 
	} forEach _hitpoints;
	};
	};

	//Repairing Vehicles
	if ((dayz_myCursorTarget != cursorTarget) and _isVehicle and !_isMan and _hasToolbox and (damage cursorTarget < 1)) then {
		_vehicle = cursorTarget;
		{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
		dayz_myCursorTarget = _vehicle;

		_allFixed = true;
		_hitpoints = _vehicle call vehicle_getHitpoints;

		{
			_damage = [_vehicle,_x] call object_getHit;

			_cmpt = toArray (_x);
			_cmpt set [0,20];
			_cmpt set [1,toArray ("-") select 0];
			_cmpt set [2,20];
			_cmpt = toString _cmpt;









			_configVeh = configFile >> "cfgVehicles" >> "RepairParts" >> _x;
			_part = getText(_configVeh >> "part");
			if (isnil ("_part")) then { _part = "PartGeneric"; };

			// get every damaged part no matter how tiny damage is!
			_damagePercent = round((1 - _damage) * 100);
			if (_damage > 0) then {
				_allFixed = false;
				_color = "color='#ffff00'"; //yellow
				if (_damage >= 0.5) then {_color = "color='#ff8800'";}; //orange
				if (_damage >= 0.9) then {_color = "color='#ff0000'";}; //red
				_cmpt = format[localize "str_actions_medical_09_status",_cmpt,_damagePercent];

				_string = format[localize "str_actions_medical_09",_cmpt,_color]; //Repair - Part
				_handle = dayz_myCursorTarget addAction [_string, "\z\addons\dayz_code\actions\repair.sqf",[_vehicle,_part,_x], 0, false, true, "",""];
				s_player_repairActions set [count s_player_repairActions,_handle];
			};

		} forEach _hitpoints;
		if (_allFixed) then {
			_vehicle setDamage 0;
		};
	};
	/*
	if (_isMan and !_isAlive) then {
		if (s_player_dragbody < 0) then {
			s_player_dragbody = player addAction [localize "str_action_studybody", "\z\addons\dayz_code\actions\drag_body.sqf",cursorTarget, 0, false, true, "",""];
		};
		} else {
		player removeAction s_player_dragbody;
		s_player_dragbody = -1;
	};
	*/
	if (_isMan and !_isAlive and !_isZombie) then {
		if (s_player_studybody < 0) then {
			s_player_studybody = player addAction [localize "str_action_studybody", "\z\addons\dayz_code\actions\study_body.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_studybody;
		s_player_studybody = -1;
	};

	//Remove CLOTHES
    if (_isMan and !_isAlive and !_isZombie and !_isAnimal) then {
    if (s_clothes < 0) then {
            s_clothes = player addAction [("<t color=""#FF0000"">" + ("Take Clothes") + "</t>"), "\z\addons\dayz_code\actions\removeclothes.sqf",cursorTarget, 1, false, true, "",""];
        };
    } else {
        player removeAction s_clothes;
        s_clothes = -1;
    };

} else {
	//Extras
	//Remove Parts
	{silver_myCursorTarget removeAction _x} forEach s_player_removeActions;s_player_removeActions = [];
	silver_myCursorTarget = objNull;
	//Engineering
	{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
	dayz_myCursorTarget = objNull;
	//Others
	player removeAction s_player_forceSave;
	s_player_forceSave = -1;
	player removeAction s_player_flipveh;
	s_player_flipveh = -1;
	player removeAction s_player_sleep;
	s_player_sleep = -1;
	player removeAction s_player_igniteTent;
	s_player_igniteTent = -1;
	player removeAction s_player_deleteBuild;
	s_player_deleteBuild = -1;
	player removeAction s_player_butcher;
	s_player_butcher = -1;
	player removeAction s_player_cook;
	s_player_cook = -1;
	player removeAction s_player_boil;
	s_player_boil = -1;
	player removeAction s_player_fireout;
	s_player_fireout = -1;
	player removeAction s_player_packtent;
	s_player_packtent = -1;
	player removeAction s_player_fillfuel;
	s_player_fillfuel = -1;
	player removeAction s_player_studybody;
	s_player_studybody = -1;
	
	//Dance
	player removeAction s_player_dance;
	s_player_dance = -1;

	//Remove CLOTHES
	player removeAction s_clothes;
    s_clothes = -1;

	/*
	//Drag Body
	player removeAction s_player_dragbody;
	s_player_dragbody = -1;
	*/
	//fuel
	player removeAction s_player_fillfuel20;
	s_player_fillfuel20 = -1;
	player removeAction s_player_fillfuel5;
	s_player_fillfuel5 = -1;

	//Dog
	//player removeAction s_player_tamedog;
	//s_player_tamedog = -1;
	player removeAction s_player_feeddog;
	s_player_feeddog = -1;
	player removeAction s_player_waterdog;
	s_player_waterdog = -1;
	player removeAction s_player_staydog;
	s_player_staydog = -1;
	player removeAction s_player_trackdog;
	s_player_trackdog = -1;
	player removeAction s_player_barkdog;
	s_player_barkdog = -1;
	player removeAction s_player_warndog;
	s_player_warndog = -1;
	player removeAction s_player_followdog;
	s_player_followdog = -1;
};
