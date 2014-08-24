if(isServer) then {

	private 		["_mission","_position","_crate","_playerPresent","_rndnum","_rndgro","_num_guns","_num_tools","_num_items"];

	_position		= [30] call init_mission;
	_mission		= [_position,"Medium","Weapon Cache","MainHero",true] call init_mission;
	diag_log 		format["WAI: Mission Weapon cache started at %1",_position];

	_num_guns		= (3 + round(random 12));
	_num_tools		= 2;
	_num_items		= 2;

	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_rndnum 	= (1 + round(random 7));
	_rndgro 	= (1 + round(random 3));

	for "_i" from 0 to _rndgro do {
		[[_position select 0, _position select 1, 0],_rndnum,"Easy","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	};

	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[], 	// cleanup objects
		"Bandits have obtained a weapon crate. Check your map for the location!",	// mission announcement
		"Survivors have secured the weapon cache!",									// mission success
		"Survivors did not secure the weapon cache in time"							// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission weapon cache ended at %1",_position];
	h_missionrunning = false;
};