Deployable Vehicles for DayZ
================

<b>NOTE:</b> This addon is currently *not* fit for release and use by the general public. Use at your own risk, support will not be given until it is considered fit for release.

Installation Instructions:

1. Copy the downloaded "custom" folder inside your mission pbo.
2. Insert this into the end of your mission init.sqf:

 __initDeployables = [] execVM "custom\init_deployablebikes.sqf";

3. Edit your BattlEye/publicvariable.txt. Add !"pvDeployables" to the end of the first non-commented line.
