class_name TileMapGenerator
extends Node2D

@export var climbable_width: int = 18;
@export var climbable_height: int  = 5;
@export var time_before_initial_fire: float = 10;
@export var time_between_fires: float = 10;
@export var time_between_fire_spread: float = 5;

@onready var fire_timer: Timer = $FireTimer

var tile_set = preload("res://assets/sprites/resources/ranger_tile_set.tres");


func _ready() -> void:
	call_deferred("_generate_tiles");


func _generate_tiles():
	var tile_map: TileMapLayer = TileMapLayer.new();
	tile_map.global_position = Vector2(-8,-8);
	tile_map.tile_set = tile_set;
	var grid_size = Vector2(climbable_width, climbable_height);
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile_id = 0;
			if (x == 0):
				if (y == 0):
					#bottom left corner
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0,5));
				elif (y == climbable_height-1):
					#top left corner
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0, 0));
				else:
					#left wall
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0, randi() % 4 + 1));
			elif (y == 0):
				if (x == climbable_width-1):
					#bottom right corner
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(5, 5));
				else:
					#bottom edge
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(randi() % 4 + 1, 5));
			elif (x == climbable_width - 1):
				if (y == climbable_height-1):
					#top right corner
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(5, 0));
				else:
					#right wall
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(5, randi() % 4 + 1));
			elif (y == climbable_height -1):
				#top edge
				tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(randi() % 4 + 1, 0));
			else:
				#center
				tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(randi() % 4 + 1, randi() % 4 + 1));
	self.get_parent().add_child(tile_map);
