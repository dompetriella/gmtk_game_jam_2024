class_name HazardGenerator
extends Node2D

@onready var fire_timer: Timer = $"%FireTimer";

var base_size: Vector2;
var tile_map: TileMapLayer
var hazard_scene: PackedScene = preload("res://tile_map_generator/hazard.tscn");
var fire_animated_sprite = preload("res://assets/sprites/test/fire.tres");
var hazard_list: Array[Hazard] = [];


func _ready() -> void:
	base_size = Vector2(get_parent().climbable_width, get_parent().climbable_height);
	self.call_deferred("_generate_area_2d_hazard_base_layer");
	var tile_generator: TileMapGenerator = self.get_parent();
	fire_timer.wait_time = tile_generator.time_before_initial_fire;
	fire_timer.one_shot = true;
	fire_timer.start();

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
		hazard_list.append(hazard);
		self.add_child(hazard);
	
func _on_fire_timer_timeout() -> void:
	var hazard_children: Array[Node] = self.get_children();
	for hazard: Hazard in hazard_children:
		if (hazard.hazard_coordinate == Vector2(0,0)):
			hazard.is_on_fire = true;
			hazard.set_animated_sprite(fire_animated_sprite);
			
			
func _add_fire_timer_to_neighbors(neighbor: Hazard) -> void:
	pass;

func _get_area_neighbors(current_tile: Vector2) -> Array[Hazard]:
	return [];
