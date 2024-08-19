extends ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile_generator: TileMapGenerator = get_tree().get_first_node_in_group(NodeGroups.tile_generator);
	var hazard_generator: HazardGenerator = get_tree().get_first_node_in_group(NodeGroups.hazard_generator);
	
	#remove the tiles that can't catch fire
	if (tile_generator != null):
		self.max_value = (tile_generator.climbable_width * tile_generator.climbable_height) - (tile_generator.climbable_width * 3);
		var current_meter: float = 0;
		for hazard_children: Hazard in hazard_generator.get_children():
			if (hazard_children.is_on_fire):
				current_meter += 1;
		self.value = max_value - current_meter;
	
	if (self.value <= 0):
		Globals.current_level = 1;
		get_tree().change_scene_to_file("res://UI/game_over/game_over.tscn");
