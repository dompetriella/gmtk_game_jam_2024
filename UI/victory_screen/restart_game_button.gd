extends TextureButton

func _on_pressed() -> void:
	Globals.current_level = 1;
	get_tree().change_scene_to_file("res://main.tscn");
