extends ProgressBar

@onready var player: Player = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.min_value = 0;
	self.max_value = player.energy_capacity;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = player.current_energy;

	if (self.value <= 0):
		Globals.current_level = 1;
		get_tree().change_scene_to_file("res://UI/game_over/game_over.tscn");
