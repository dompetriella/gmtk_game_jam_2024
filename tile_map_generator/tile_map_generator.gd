extends Node2D

@export var climbable_width: int = 18;
@export var climbable_height: int  = 5;

func _ready() -> void:
	call_deferred("_generate_tiles");
	pass;

func _generate_tiles():
	var tile_map: TileMapLayer = TileMapLayer.new();
	tile_map.tile_set = preload("res://assets/sprites/test/new_tile_set.tres");
	var grid_size = Vector2(climbable_width, climbable_height);
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile_id = 0;
			if (x == 0):
				if (y == 0):
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0,2));
				elif (y == climbable_height-1):
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0, 0));
				else:
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(0, 1));
			elif (y == 0):
				if (x == climbable_width-1):
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(2, 2));
				else:
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(1, 2));
			elif (x == climbable_width - 1):
				if (y == climbable_height-1):
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(2, 0));
				else:
					tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(2, 1));
			elif (y == climbable_height -1):
				tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(1, 0));
			else:
				tile_map.set_cell(Vector2i(x, -y), 0, Vector2i(1,1));
	self.get_parent().add_child(tile_map);
