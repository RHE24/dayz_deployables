if (isDedicated) then {
	"pvDeployables" addPublicVariableEventHandler {
		private ["_mode","_player","_object","_target"];
		_mode = (_this select 1) select 0;
		_player = (_this select 1) select 1;
		_target = (_this select 1) select 2;

		switch (_mode) do {
			case 0: {
				//Delete vehicle
				deleteVehicle _target;
			};
			case 1: {
				//Unpack old bike
				_object = createVehicle ["Old_bike_TK_CIV_EP1", (getPosATL _player), [], 0, "NONE"];
				_object setVariable ["ObjectID", "1"];
				_object setVariable ["DZAI",1];
				_object setPosATL (getPosATL _player);
				_player reveal _object;
			};
			case 2: {
				//Return parts.
				if (_target == "TT650_Civ") then {
					_object = createVehicle ["WeaponHolder", (getPosATL _player), [], 0, "NONE"];
					_object addMagazinecargo ["PartGeneric", 1]; 
					_object addMagazinecargo ["PartEngine", 1];
					_object setPosATL (getPosATL _player);
				} else {
					if (_target == "CSJ_GyroC") then {
						_object = createVehicle ["WeaponHolder", (getPosATL _player), [], 0, "NONE"];
						_object addMagazinecargo ["PartGeneric", 1]; 
						_object addMagazinecargo ["PartVRotor", 1];
						_object setPosATL (getPosATL _player);
					};
				};
			};
			case 3: {
				//Upgrade to motorbike
				_object = createVehicle ["TT650_Civ", (getPosATL _player), [], 0, "NONE"];
				_object setVariable ["ObjectID", "1"];
				_object setVariable ["DZAI",1];
				_object setFuel 0.5;
				_object setPosATL (getPosATL _player);
				_player reveal _object;
			};
			case 5: {
				//Unpack gyrocopter
				_object = createVehicle ["CSJ_GyroC", (getPosATL _player), [], 0, "NONE"];
				_object setVariable ["ObjectID", "1"];
				_object setVariable ["DZAI",1];
				_object setFuel 0.5;
				_object setPosATL (getPosATL _player);
				_player reveal _object;

			};
		};
		pvDeployables = [];
	};
} else {
	_deployableBike = [] spawn {
		waitUntil {!isNil "fnc_usec_selfActions"};
		fnc_usec_selfActions = compile preprocessFileLineNumbers "custom\fn_selfActions.sqf";
	};
};