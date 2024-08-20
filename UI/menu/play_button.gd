extends TextureButton


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/tutorial/tutorial.tscn");


func _on_credits_button_pressed() -> void:
		get_tree().change_scene_to_file("res://UI/Credits.tscn");
