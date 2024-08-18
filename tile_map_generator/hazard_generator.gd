class_name HazardGenerator
extends Node2D

@onready var fire_timer: Timer = $"%FireTimer";
@onready var tile_map_generator: TileMapGenerator = $".."
@onready var fire_seed_timer: Timer = $"../FireSeedTimer"


var base_size: Vector2;
var tile_map: TileMapLayer
var hazard_scene: PackedScene = preload("res://tile_map_generator/hazard.tscn");
var fire_animated_sprite = preload("res://assets/sprites/resources/fire.tres");
var hazard_list: Array[Hazard] = [];
var time_before_initial_fire: float;
var time_between_fires: float;
var time_between_spreading_fire: float;


func _ready() -> void:
	self.call_deferred("_generate_area_2d_hazard_base_layer");
	
	
	base_size = Vector2(tile_map_generator.climbable_width, tile_map_generator.climbable_height);
	time_before_initial_fire = tile_map_generator.time_before_initial_fire;
	time_between_fires = tile_map_generator.time_between_fires;
	time_between_spreading_fire = tile_map_generator.time_between_fire_spread;
	fire_timer.wait_time = time_before_initial_fire;
	fire_timer.one_shot = true;

func _turn_on_fire_timers():
	fire_timer.start();
	fire_seed_timer.star();

func _generate_area_2d_hazard_base_layer():
	var total: int = base_size.x * base_size.y;
	var x_divider: int = base_size.x;
	for x in range(base_size.x * base_size.y):
		var hazard: Hazard = hazard_scene.instantiate();
		var x_coordinate: int = int(x % x_divider);
		var y_coordinate: int = int(floor( x / x_divider));
		hazard.global_position = Vector2(x_coordinate * Globals.pixel_size, -1 * y_coordinate * 16);
		hazard.z_index = 1;
		hazard.hazard_list_index = x;
		hazard.hazard_coordinate = Vector2(x_coordinate, y_coordinate);
		if (y_coordinate == base_size.y-1):
			hazard.is_finishing_tile = true;
		hazard_list.append(hazard);
		self.add_child(hazard);
	
func _on_fire_timer_timeout() -> void:
	_fire_timer_timeout();
	
func _fire_timer_timeout():
	var hazard_children: Array[Node] = self.get_children();
	var first_fire_tile_vector: Vector2;
	var i: int = 0;
	while (true):
		i += 1;
		first_fire_tile_vector = Vector2((randi() % int(base_size.x)), (randi() % int(base_size.y) + 2));
		for hazard: Hazard in hazard_children:
			if (hazard.hazard_coordinate == first_fire_tile_vector && hazard.is_on_fire == false):
				hazard.is_on_fire = true;
				hazard.set_animated_sprite(fire_animated_sprite);
				break;
			break;
		if (i >= 50):
			break;
	_set_fire_to_neighbors(first_fire_tile_vector);

func _set_fire_to_neighbors(current_hazard_vector: Vector2):
		var new_hazard_tiles: Array[Hazard] = _get_area_neighbors(current_hazard_vector);
		for new_hazard: Hazard in new_hazard_tiles:
			_add_fire_timer_to_neighbors(new_hazard, 10);

func _get_area_neighbors(current_tile: Vector2) -> Array[Hazard]:
	var hazard_children: Array[Node] = self.get_children();
	var hazard_tiles: Array[Hazard] = [];
	for hazard in hazard_children:
		if (
			# right
			hazard.hazard_coordinate == Vector2(current_tile.x + 1, current_tile.y) || 
			#left
			hazard.hazard_coordinate == Vector2(current_tile.x - 1, current_tile.y) || 
			#up
			hazard.hazard_coordinate == Vector2(current_tile.x, current_tile.y - 1) || 
			#down
			hazard.hazard_coordinate == Vector2(current_tile.x, current_tile.y + 1)):
				if (hazard.hazard_coordinate.y > 2 && hazard.hazard_coordinate.y < base_size.y - 1):
					hazard_tiles.append(hazard);
	return hazard_tiles;

func _add_fire_timer_to_neighbors(neighbor: Hazard, old_timer: float) -> void:
	if (!neighbor.is_on_fire):
		neighbor.is_on_fire = true;
		neighbor.set_animated_sprite(fire_animated_sprite);
		var new_fire_timer: Timer = Timer.new();
		new_fire_timer.autostart = true;
		new_fire_timer.wait_time = time_between_spreading_fire;
		new_fire_timer.timeout.connect(_set_fire_to_neighbors.bind(neighbor.hazard_coordinate));
		neighbor.add_child(new_fire_timer);
		


func _on_fire_seed_timer_timeout() -> void:
	_fire_timer_timeout();
