class_name BuildOnChoiceScreen
extends Control

@onready var build_on_choice_1: BuildOnInteractable = $BuildOnChoice1
@onready var build_on_choice_2: BuildOnInteractable = $BuildOnChoice2
@onready var build_on_choice_3: BuildOnInteractable = $BuildOnChoice3


var build_on_1: BuildOn;
var build_on_2: BuildOn;
var build_on_3: BuildOn;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_on_1 = Globals.all_build_ons.pick_random();
	build_on_2 = Globals.all_build_ons.pick_random();
	build_on_3 = Globals.all_build_ons.pick_random();
