extends Node

#player
signal player_takes_energy_damage(damage: float);
signal player_enter_cutscene(cutscene_type: int);
signal player_exit_cutscene();

#hazard
signal dowse_hazard_tile(hazard_tile_id: int);
