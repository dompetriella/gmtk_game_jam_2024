extends VBoxContainer

const BUILD_ON_UI = preload("res://UI/build_on/build_on_ui.tscn")

func _ready() -> void:
	Events.build_on_chosen.connect(_show_new_build_on);
	
func _show_new_build_on(build_on: BuildOn):
	var build_on_ui_scene = BUILD_ON_UI.instantiate();
	var texture: Texture2D = load(build_on.sprite_path)
	build_on_ui_scene.texture = texture;
	self.add_child(build_on_ui_scene);
