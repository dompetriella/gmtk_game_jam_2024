class_name BuildOnInteractable
extends Control

@export var index: int;

@onready var icon: TextureRect = $GPUParticles2D/Icon
@onready var title: Label = $Title
@onready var description: Label = $Description

var build_on: BuildOn;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gui_input.connect(_on_click);
	build_on = Globals.current_selection_build_ons[index];
	title.text = build_on.title;
	description.text = build_on.description;
	icon.texture = load(build_on.sprite_path);

func _on_click(event: InputEvent):
	if (event is InputEventMouseButton):
		var mouse_event = event as InputEventMouseButton;
		if (mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed):
			Globals.current_player_build_ons.append(build_on);
			Events.build_on_chosen.emit(build_on);
			_add_immediate_build_on(build_on);
			if Globals.available_build_ons.has(build_on):
				Globals.available_build_ons.erase(build_on);
			Globals.current_level = Globals.current_level + 1;
			Events.build_new_level.emit();
			Events.hide_build_on_options.emit();
			Events.player_enter_cutscene.emit(Enums.cutscene_type.LEAVE_STATION);

func _add_immediate_build_on(build_on: BuildOn):
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);
	if (build_on.id == Enums.build_ons.ENERGY_BRACER):
		player.energy_capacity = player.energy_capacity * 1.5;
	if (build_on.id == Enums.build_ons.EFFICIENT_ENGINE):
		player.energy_usage_rate = player.energy_usage_rate / 2;
	if (build_on.id == Enums.build_ons.MECHANICAL_ARM):
		player.speed = player.speed * 1.25;
	if (build_on.id == Enums.build_ons.CONDENSED_BATTERY):
		player.energy_capacity = player.energy_capacity * 0.8;
	if (build_on.id == Enums.build_ons.HEAVY_BATTERY):
		player.energy_capacity = player.energy_capacity * 2;
		player.speed = player.speed * 0.8;
