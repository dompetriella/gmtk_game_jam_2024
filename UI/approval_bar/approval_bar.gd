extends TextureProgressBar

var total_approval = 1000;
var current_approval = 1000;

func _ready() -> void:
	Events.adjust_approval.connect(func(amount):
		if (current_approval + amount >= total_approval):
			current_approval = total_approval;
		else:
			current_approval += amount;
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile_generator: TileMapGenerator = get_tree().get_first_node_in_group(NodeGroups.tile_generator);
	var hazard_generator: HazardGenerator = get_tree().get_first_node_in_group(NodeGroups.hazard_generator);
	
	self.max_value = total_approval;
	self.value = current_approval; 
	
	if (self.value <= 0):
		var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
		player.in_cutscene = true;
		var movement_tween: Tween = create_tween();
		movement_tween.tween_property(player, "global_position", Vector2(player.global_position.x, 40), (1)).from_current();
		Events.fade_to_black.emit();
		await get_tree().create_timer(2).timeout;
		Globals.current_level = 1;
		get_tree().change_scene_to_file("res://UI/game_over/game_over.tscn");
