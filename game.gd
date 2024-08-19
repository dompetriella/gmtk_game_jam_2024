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
	
	match Globals.current_level:
		2:
			new_level.climbable_height = level2_height;
			new_level.time_before_initial_fire = level2_time_before_initial_fire;
			
			new_level.time_between_fires = level2_time_between_fires;
			
			new_level.time_between_fire_spread = level2_time_between_fire_spread;
			new_level.name = "Level 2";
		3:
			new_level.climbable_height = level3_height;
			new_level.time_before_initial_fire = level3_time_before_initial_fire;
			
			new_level.time_between_fires = level3_time_between_fires;
			
			new_level.time_between_fire_spread = level3_time_between_fire_spread;
			new_level.name = "Level 3";
			new_level.modulate = Color.RED;
		4:
			new_level.climbable_height = level4_height;
			new_level.time_before_initial_fire = level4_time_before_initial_fire;
			
			new_level.time_between_fires = level4_time_between_fires;
			
			new_level.time_between_fire_spread = level4_time_between_fire_spread;	
			new_level.name = "Level 4";	
			new_level.modulate = Color.BLUE;
		5:
			new_level.climbable_height = level5_height;
			new_level.time_before_initial_fire = level5_time_before_initial_fire;
			
			new_level.time_between_fires = level5_time_between_fires;
			
			new_level.time_between_fire_spread = level5_time_between_fire_spread;
			new_level.name = "Level 5";
			new_level.modulate = Color.YELLOW;
	
	self.remove_child(tile_generator);
	tile_generator.queue_free();
	self.add_child(new_level);
