Deployable Vehicles for DayZ
================

Installation Instructions:

1. Copy the downloaded "custom" folder inside your mission pbo.
2. Insert this into the end of your mission init.sqf:

<<<<<<< HEAD
 __initDeployables = [] execVM "custom\init_deployablebikes.sqf";
=======
	_initDeployables = [] execVM "custom\init_deployablebikes.sqf";
>>>>>>> cf7a1fea1274c620241a3e9ab5a80a90a49b7f48

3. Edit your BattlEye/publicvariable.txt. Add !"pvDeployables" to the end of the first non-commented line.
