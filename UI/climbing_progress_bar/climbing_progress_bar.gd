extends ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile_generator: TileMapGenerator = get_tree().get_first_node_in_group(NodeGroups.tile_generator);
	self.max_value = (tile_generator.climbable_height-1) * 16;
	
	var player = get_tree().get_first_node_in_group(NodeGroups.player);
	self.value = (player.global_position.y * -1) - 4;
