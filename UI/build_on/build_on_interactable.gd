class_name BuildOnInteractable
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gui_input.connect(_on_click);

func _on_click(event: InputEvent):
	if (event is InputEventMouseButton):
		var mouse_event = event as InputEventMouseButton;
		if (mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed):
			print('hllo');
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;
