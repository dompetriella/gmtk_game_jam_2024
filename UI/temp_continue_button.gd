extends Button

func _on_pressed() -> void:
	Events.build_on_chosen.emit();
