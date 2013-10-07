Deployable Vehicles for DayZ
================

Installation Instructions:

1. Copy the downloaded "custom" folder inside your mission pbo.
2. Insert this into the end of your mission init.sqf:

_initDeployables = [] execVM "custom\init_deployablebikes.sqf";

3. Edit your BattlEye/publicvariable.txt. Add !"pvDeployables" to the end of the first non-commented line.
