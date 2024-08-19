extends CanvasLayer

const build_on_choice_screen = preload("res://UI/build_on/build_on_choice_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.show_build_on_options.connect(_generate_and_show_build_ons);


func _generate_and_show_build_ons():
	var build_on_screen = build_on_choice_screen.instantiate();
	self.add_child(build_on_screen);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
