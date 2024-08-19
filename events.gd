extends Node

#game
signal build_new_level;

#player
signal player_takes_energy_damage(damage: float);
signal player_enter_cutscene(cutscene_type: Enums.cutscene_type);
signal player_exit_cutscene;
signal fade_to_black;
signal fade_from_black;
signal show_build_on_options;
signal hide_build_on_options;
signal build_on_chosen;
signal reset_player_to_origin;

#hazard
signal start_fires;
signal dowse_hazard_tile(hazard_tile_id: int);

#etc
signal set_station_to_front;
signal set_station_to_back;
