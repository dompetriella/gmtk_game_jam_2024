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
