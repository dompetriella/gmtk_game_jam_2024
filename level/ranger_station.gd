extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Globals.current_level == 1):
		visible = false;
	else:
		visible = true;
