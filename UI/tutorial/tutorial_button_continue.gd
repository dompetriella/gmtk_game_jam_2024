extends TextureButton

func _on_pressed() -> void:
	Events.play_main_theme.emit();
	get_tree().change_scene_to_file("res://game.tscn");
