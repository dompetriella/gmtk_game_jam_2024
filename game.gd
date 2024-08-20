extends Node2D

var tile_generator: TileMapGenerator;
const tile_map_generator = preload("res://tile_map_generator/tile_map_generator.tscn")

var level2_height: int = 150;
var level2_time_before_initial_fire: float = 3;
var level2_time_between_fires: float = 15;
var level2_time_between_fire_spread: float = 10;


var level3_height: int = 200;
var level3_time_before_initial_fire: float = 3;
var level3_time_between_fires: float = 15;
var level3_time_between_fire_spread: float = 10;


var level4_height: int = 250;
var level4_time_before_initial_fire: float = 3;
var level4_time_between_fires: float = 15;
var level4_time_between_fire_spread: float = 10;


var level5_height: int = 300;
var level5_time_before_initial_fire: float = 3;
var level5_time_between_fires: float = 15;
var level5_time_between_fire_spread: float = 10;

func _ready() -> void:
	_generate_build_ons();
	Events.build_new_level.connect(_generate_next_level);
	Events.create_build_on_choices.connect(_generate_build_on_end_level_selection)

func _generate_build_on_end_level_selection():
	Globals.current_selection_build_ons = [];
	var available_list: Array[BuildOn] = Globals.available_build_ons;
	available_list.shuffle();
	var new_current_selection: Array[BuildOn] = available_list.slice(0, 3);
	for x in new_current_selection:
		print(x.title);
	Globals.current_selection_build_ons = new_current_selection;

func _generate_next_level():
	print('current level ' + str(Globals.current_level));
	var game_children: Array[Node] = self.get_children();
	for child in game_children:
		if (child is TileMapGenerator):
			tile_generator = child;
		
	var new_level: TileMapGenerator = tile_map_generator.instantiate();
	
	# not my finest work but whatevs lol
	match Globals.current_level:
		2:
			new_level.climbable_height = level2_height;
			new_level.time_before_initial_fire = level2_time_before_initial_fire;
			
			new_level.time_between_fires = level2_time_between_fires;
			
			new_level.time_between_fire_spread = level2_time_between_fire_spread;
			new_level.name = "Level 2";
			
			#darker
			var modulate_color = modulate
			modulate_color.r *= 0.9  # Increase the red component
			modulate_color.g *= 1.1  # Slightly decrease the green component
			modulate_color.b *= 0.9  # Slightly decrease the blue component

			new_level.modulate = modulate_color
		3:
			new_level.climbable_height = level3_height;
			new_level.time_before_initial_fire = level3_time_before_initial_fire;
			
			new_level.time_between_fires = level3_time_between_fires;
			
			new_level.time_between_fire_spread = level3_time_between_fire_spread;
			new_level.name = "Level 3";
			
			#greener
			var modulate_color = modulate
			modulate_color.r *= 0.8  # Increase the red component
			modulate_color.g *= 1.1  # Slightly decrease the green component
			modulate_color.b *= 0.9  # Slightly decrease the blue component

			new_level.modulate = modulate_color
		
		4:
			new_level.climbable_height = level4_height;
			new_level.time_before_initial_fire = level4_time_before_initial_fire;
			
			new_level.time_between_fires = level4_time_between_fires;
			
			new_level.time_between_fire_spread = level4_time_between_fire_spread;	
			new_level.name = "Level 4";	
			
			#reddish tint
			var modulate_color = modulate
			modulate_color.r *= 1.05  # Increase the red component
			modulate_color.g *= 0.95  # Slightly decrease the green component
			modulate_color.b *= 0.95  # Slightly decrease the blue component

			new_level.modulate = modulate_color
			
		5:
			new_level.climbable_height = level5_height;
			new_level.time_before_initial_fire = level5_time_before_initial_fire;
			
			new_level.time_between_fires = level5_time_between_fires;
			
			new_level.time_between_fire_spread = level5_time_between_fire_spread;
			new_level.name = "Level 5";
			
			#reddish tint
			var modulate_color = modulate
			modulate_color.r *= 1.2  # Increase the red component
			modulate_color.g *= 0.7  # Slightly decrease the green component
			modulate_color.b *= 0.7  # Slightly decrease the blue component

			new_level.modulate = modulate_color
	
	self.remove_child(tile_generator);
	tile_generator.queue_free();
	self.add_child(new_level);


func _on_timer_timeout() -> void:
	Events.start_fires.emit();
	
func _generate_build_ons():

	var condensed_battery: BuildOn = BuildOn.new()
	condensed_battery.id = Enums.build_ons.CONDENSED_BATTERY
	condensed_battery.title = "Condensed Battery"
	condensed_battery.description = "Moving doesn't use energy but energy capacity is decreased by 20%"  # Add your description here
	condensed_battery.sprite_path = "res://assets/sprites/exports/build_ons/condensed-battery-icon-sprite.png"
	Globals.all_build_ons.append(condensed_battery)

	var efficient_engine: BuildOn = BuildOn.new()
	efficient_engine.id = Enums.build_ons.EFFICIENT_ENGINE
	efficient_engine.title = "Efficient Engine"
	efficient_engine.description = "Greatly reduces energy consumption"  # Add your description here
	efficient_engine.sprite_path = "res://assets/sprites/exports/build_ons/efficient-engine-icon-sprite.png"
	Globals.all_build_ons.append(efficient_engine)

	var energy_bracer: BuildOn = BuildOn.new()
	energy_bracer.id = Enums.build_ons.ENERGY_BRACER
	energy_bracer.title = "Energy Bracer"
	energy_bracer.description = "Greatly increases energy capacity"  # Add your description here
	energy_bracer.sprite_path = "res://assets/sprites/exports/build_ons/energy-bracer-icon-sprite.png"
	Globals.all_build_ons.append(energy_bracer)

	var fireproof_chassis: BuildOn = BuildOn.new()
	fireproof_chassis.id = Enums.build_ons.FIREPROOF_CHASSIS
	fireproof_chassis.title = "Fireproof Chassis"
	fireproof_chassis.description = "Negates damage from fire"  # Add your description here
	fireproof_chassis.sprite_path = "res://assets/sprites/exports/build_ons/fire-proof-icon-sprite.png"
	Globals.all_build_ons.append(fireproof_chassis)

	var heavy_battery: BuildOn = BuildOn.new()
	heavy_battery.id = Enums.build_ons.HEAVY_BATTERY
	heavy_battery.title = "Heavy Battery"
	heavy_battery.description = "Enormously increases energy capacity but reduces speed by 20%"  # Add your description here
	heavy_battery.sprite_path = "res://assets/sprites/exports/build_ons/heavy-battery-icon-sprite.png"
	Globals.all_build_ons.append(heavy_battery)

	var hydrolic_engine: BuildOn = BuildOn.new()
	hydrolic_engine.id = Enums.build_ons.HYDROLIC_ENGINE
	hydrolic_engine.title = "Hydrolic Engine"
	hydrolic_engine.description = "Using the extinguisher doesn't use energy"  # Add your description here
	hydrolic_engine.sprite_path = "res://assets/sprites/exports/build_ons/hydraulic-engine-icon-sprite.png"
	Globals.all_build_ons.append(hydrolic_engine)

	var jet_propulsion: BuildOn = BuildOn.new()
	jet_propulsion.id = Enums.build_ons.JET_PROPULSION
	jet_propulsion.title = "Jet Propulsion"
	jet_propulsion.description = "Move much faster while extinguishing"  # Add your description here
	jet_propulsion.sprite_path = "res://assets/sprites/exports/build_ons/jet-propulsion-icon-sprite.png"
	Globals.all_build_ons.append(jet_propulsion)

	var mechanical_arm: BuildOn = BuildOn.new()
	mechanical_arm.id = Enums.build_ons.MECHANICAL_ARM
	mechanical_arm.title = "Mechanical Arm"
	mechanical_arm.description = "Energy is not lost when not moving, and movement speed is increased"  # Add your description here
	mechanical_arm.sprite_path = "res://assets/sprites/exports/build_ons/mechanical-arm-icon-sprite.png"
	Globals.all_build_ons.append(mechanical_arm)

	var mega_hose: BuildOn = BuildOn.new()
	mega_hose.id = Enums.build_ons.MEGA_HOSE
	mega_hose.title = "Mega Hose"
	mega_hose.description = "Greatly extinguisher radius"  # Add your description here
	mega_hose.sprite_path = "res://assets/sprites/exports/build_ons/mega-hose-icon-sprite.png"
	Globals.all_build_ons.append(mega_hose)

	var smother_blanket: BuildOn = BuildOn.new()
	smother_blanket.id = Enums.build_ons.SMOTHER_BLANKET
	smother_blanket.title = "Smother Blanket"
	smother_blanket.description = "Moving over fire extinguishes it"  # Add your description here
	smother_blanket.sprite_path = "res://assets/sprites/exports/build_ons/smother-blanket-icon-sprite.png"
	Globals.all_build_ons.append(smother_blanket)

	#var solar_battery: BuildOn = BuildOn.new()
	#solar_battery.id = Enums.build_ons.SOLAR_BATTERY
	#solar_battery.title = "Solar Battery"
	#solar_battery.description = "Passively regenerate energy"  # Add your description here
	#solar_battery.sprite_path = "res://assets/sprites/exports/build_ons/solar-powered-icon-sprite.png"
	#Globals.all_build_ons.append(solar_battery)

	
	print(Globals.all_build_ons);
	Globals.available_build_ons = Globals.all_build_ons;
	

	
