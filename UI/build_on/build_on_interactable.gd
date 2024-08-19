class_name BuildOnInteractable
extends Control

@export var index: int;

@onready var icon: TextureRect = $GPUParticles2D/Icon
@onready var title: Label = $Title
@onready var description: Label = $Description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gui_input.connect(_on_click);
	var build_on: BuildOn = Globals.current_selection_build_ons[index];
	title.text = build_on.title;

func _on_click(event: InputEvent):
	if (event is InputEventMouseButton):
		var mouse_event = event as InputEventMouseButton;
		if (mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed):
			Globals.current_level = Globals.current_level + 1;
			Events.build_new_level.emit();
			Events.hide_build_on_options.emit();
			Events.player_enter_cutscene.emit(Enums.cutscene_type.LEAVE_STATION);
