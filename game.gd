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
	Events.build_new_level.connect(_generate_next_level);
	_generate_build_ons();
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
	
	var combustion_engine: BuildOn = BuildOn.new();
	combustion_engine.id = Enums.build_ons.COMBUSTION_ENGINE;
	combustion_engine.title = "Combustion Engine";
	combustion_engine.description = "Moving through fire increase speed by 50%";
	var combustion_engine_sprite: Texture2D = Texture2D.new();
	combustion_engine_sprite.texture = load("res://assets/sprites/exports/build_ons/combustion-engine-icon-sprite.png");
	combustion_engine.sprite = combustion_engine_sprite
	Globals.all_build_ons.append(combustion_engine);
	
	var condensed_battery: BuildOn = BuildOn.new();
	condensed_battery.id = Enums.build_ons.CONDENSED_BATTERY;
	condensed_battery.title = "Condensed Battery";
	condensed_battery.description = "Reduces energy capacity but doesn't use energy while moving";
	var condensed_battery_sprite: Texture2D = Texture2D.new();
	condensed_battery_sprite.texture = load("res://assets/sprites/exports/build_ons/condensed-battery-icon-sprite.png");
	condensed_battery.sprite = condensed_battery_sprite
	Globals.all_build_ons.append(condensed_battery);

	var efficient_engine: BuildOn = BuildOn.new();
	efficient_engine.id = Enums.build_ons.EFFICIENT_ENGINE;
	efficient_engine.title = "Efficient Engine";
	efficient_engine.description = "Energy usage decreased by 25%";
	var efficient_engine_sprite: Texture2D = Texture2D.new();
	efficient_engine_sprite.texture = load("res://assets/sprites/exports/build_ons/efficient-engine-icon-sprite.png");
	efficient_engine.sprite = efficient_engine_sprite
	Globals.all_build_ons.append(efficient_engine);
	
	var energy_bracer: BuildOn = BuildOn.new();
	energy_bracer.id = Enums.build_ons.ENERGY_BRACER;
	energy_bracer.title = "Energy Bracer";
	energy_bracer.description = "Increase Energy Capacity by 50%";
	var energy_bracer_sprite: Texture2D = Texture2D.new();
	energy_bracer_sprite.texture = load("res://assets/sprites/exports/build_ons/energy-bracer-icon-sprite.png");
	energy_bracer.sprite = energy_bracer_sprite
	Globals.all_build_ons.append(energy_bracer);
	
	var fireproof: BuildOn = BuildOn.new();
	fireproof.id = Enums.build_ons.FIREPROOF_CHASSIS;
	fireproof.title = "Fire-Proof";
	fireproof.description = "Decrease fire damage by 50%";
	var fireproof_sprite: Texture2D = Texture2D.new();
	fireproof_sprite.texture = load("res://assets/sprites/exports/build_ons/fire-proof-icon-sprite.png");
	fireproof.sprite = fireproof_sprite
	Globals.all_build_ons.append(fireproof);
	
	var heavy_battery: BuildOn = BuildOn.new();
	heavy_battery.id = Enums.build_ons.HEAVY_BATTERY;
	heavy_battery.title = "Heavy Battery";
	heavy_battery.description = "Doubles energy capacity.  Move 20% slower.";
	var heavy_battery_sprite: Texture2D = Texture2D.new();
	heavy_battery_sprite.texture = load("res://assets/sprites/exports/build_ons/heavy-battery-icon-sprite.png");
	heavy_battery.sprite = heavy_battery_sprite
	Globals.all_build_ons.append(heavy_battery);
	
	var hydrolic_engine: BuildOn = BuildOn.new();
	hydrolic_engine.id = Enums.build_ons.HYDROLIC_ENGINE;
	hydrolic_engine.title = "Heavy Battery";
	hydrolic_engine.description = "Doubles energy capacity.  Move 20% slower.";
	var hydrolic_engine_sprite: Texture2D = Texture2D.new();
	hydrolic_engine_sprite.texture = load("res://assets/sprites/exports/build_ons/heavy-battery-icon-sprite.png");
	hydrolic_engine.sprite = hydrolic_engine_sprite
	Globals.all_build_ons.append(hydrolic_engine);
