extends Node

#player
signal player_takes_energy_damage(damage: float);
signal player_enter_cutscene(cutscene_type: int);
signal player_exit_cutscene();
signal fade_to_black();
signal fade_from_black();

#hazard
signal start_fires();
signal dowse_hazard_tile(hazard_tile_id: int);
