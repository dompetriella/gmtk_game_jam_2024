extends Node

var pixel_size: int = 16;

var current_level: int = 1;

var all_build_ons: Array[BuildOn] = [];
var available_build_ons: Array[BuildOn] = [];
var current_selection_build_ons: Array[BuildOn] = [];
var current_player_build_ons: Array[BuildOn] = [];

func check_if_player_has_build_on(build_on_type: Enums.build_ons) -> bool:
	var matching_build_on = Globals.current_player_build_ons.filter(
		func(build_on: BuildOn):
			return build_on.id == build_on_type;
	)
	if (matching_build_on.size() > 0):
		return true;
	else:
		return false;
