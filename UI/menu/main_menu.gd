extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.play_main_theme.emit();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
