extends TextureProgressBar

@onready var player: Player = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.min_value = 0;
	self.max_value = player.energy_capacity;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = player.current_energy;

	if (self.value <= 0):
		var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
		player.in_cutscene = true;
		var movement_tween: Tween = create_tween();
		movement_tween.tween_property(player, "global_position", Vector2(player.global_position.x, 40), (1)).from_current();
		Events.fade_to_black.emit();
		await get_tree().create_timer(2).timeout;
		Globals.current_level = 1;
		get_tree().change_scene_to_file("res://UI/game_over/game_over.tscn");
