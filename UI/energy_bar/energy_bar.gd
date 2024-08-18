extends ProgressBar

@onready var player: Player = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.min_value = 0;
	self.max_value = player.energy_capacity;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = player.current_energy;
