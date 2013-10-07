if (dayz_combat == 1) then { 
    cutText [format["You are in Combat and cannot Re-Pack your gyrocopter"], "PLAIN DOWN"];
} else {
	_startDeploy = time;
	player removeAction s_player_deploybike6;
	player playActionNow "Medic";
	_dis=10;
	_sfx = "repair";
	_target = _this select 3;
	_targetDamage = damage _target;
	_result = "";
	[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
	[player,_dis,true,(getPosATL player)] spawn player_alertZombies;
	////////////////////////////////////////////////
	// Fancy cancel if interrupted addition start //
	////////////////////////////////////////////////
	r_interrupt = false; // public interuppt variable
	_animState = animationState player; // get the animation state of the player
	r_doLoop = true;
	_started = false;
	_finished = false;
	while {r_doLoop} do {
		_animState = animationState player; // keep checking to make sure player is in correct animation
		_isMedic = ["medic",_animState] call fnc_inString; // checking to make sure the animstate is the medic animation still
		if (_isMedic) then {
			_started = true; // this is a check to make sure everything is still ok
		};
		if(!_isMedic && !r_interrupt && (time - _startDeploy) < 6) then {
			player playActionNow "Medic";
			_isMedic = true;
		};
		if (_started && !_isMedic && (time - _startDeploy) > 6) then {
			r_doLoop = false; // turns off the loop
			_finished = true;
		};
		if (r_interrupt) then {
			r_doLoop = false; // if interuppted turns loop off early so _finished is never true
		};
		sleep 0.1;
	};
	r_doLoop = false;  
	///////////////////////////////////////////////
	// Fancy cancel if interrupted addition end //
	//////////////////////////////////////////////
	if (_finished) then {
		pvDeployables = [0,objNull,_target];
		publicVariableServer "pvDeployables";

		sleep 2;
		if ((random 1) > _targetDamage) then {
			pvDeployables = [2,player,"CSJ_GyroC"];
			publicVariableServer "pvDeployables";
			player addWeapon "ItemToolbox";
			_result = "You have packed your gyrocopter. Your parts have been dropped on the ground.";
		} else {
			_result = "Your gyrocopter was too badly damaged and was destroyed during salvaging.";
		};
		cutText [_result, "PLAIN DOWN"];
		
		r_interrupt = false;
		player switchMove "";
		player playActionNow "stop";
	} else {
		// this is for handling if interrupted
		r_interrupt = false;
		player switchMove "";
		player playActionNow "stop";
		cutText [format["Gyrocopter packing interrupted!"], "PLAIN DOWN"]; //display text at bottom center of screen on interrupt
	};
};