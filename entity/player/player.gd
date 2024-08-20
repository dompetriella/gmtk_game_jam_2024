class_name Player
extends CharacterBody2D


@export var speed = 300.0;

@export var energy_capacity: float = 1000; 
@export var energy_usage_while_climbing: float = 8;
@export var energy_usage_while_still: float = 2;
@export var energy_usage_while_dowsing: float = 12;
@export var energy_usage_rate: float = 100;

@onready var approval_bar: TextureProgressBar = $CanvasLayer/ApprovalBar
@onready var energy_bar: TextureProgressBar = $CanvasLayer/EnergyBar

@onready var water_nozzle_area: Area2D = $WaterNozzleArea
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var water_particles: GPUParticles2D = $WaterNozzleArea/GPUParticles2D

var direction: Vector2 = Vector2.ZERO
var is_watering: bool = false;
var current_energy: float = energy_capacity;
var in_cutscene: bool = false;

var jet_propulsion_multiplier = 1;
var speed_multiplier = 1;

func _ready() -> void:
	#self.global_position = Vector2(-64, -4)
	self.global_position = Vector2(16 * 9, -16);
	water_particles.emitting = false;
	Events.player_takes_energy_damage.connect(func(energy_damage):
		if (!in_cutscene):
			current_energy = current_energy - (energy_damage / (500-energy_usage_rate));
	);
	Events.player_enter_cutscene.connect(_handle_cutscene)
	#Events.show_build_on_options.connect(_on_show_build_on_options);
	Events.player_exit_cutscene.connect(func():
		in_cutscene = false;	
	)
	Events.reset_player_to_origin.connect(_on_reset_player_to_ranger_station);



func _process(delta: float):
	
	if (!in_cutscene):
		handle_input();
		move_and_animate(delta);
		_handle_watering();
	#print(self.global_position);
	

	
func _handle_watering():
		if Input.is_action_pressed("ui_select"):
			is_watering = true;
			
			await get_tree().create_timer(0.1).timeout;
			water_particles.emitting = true;
			if !(Globals.check_if_player_has_build_on(Enums.build_ons.HYDROLIC_ENGINE)):
				Events.player_takes_energy_damage.emit(energy_usage_while_dowsing);
			if (Globals.check_if_player_has_build_on(Enums.build_ons.JET_PROPULSION)):
				self.jet_propulsion_multiplier = 2;
		else:
			is_watering = false;
			water_particles.emitting = false;
	
func handle_input():
	direction = Vector2.ZERO;

	if Input.is_action_pressed("ui_right"):
		direction.x += 1;
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1;
	if Input.is_action_pressed("ui_down"):
		direction.y += 1;
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1;

	# Normalize the direction vector to maintain consistent speed
	direction = direction.normalized();

func move_and_animate(delta: float):
	if direction != Vector2.ZERO:
		if !(Globals.check_if_player_has_build_on(Enums.build_ons.CONDENSED_BATTERY)):
			Events.player_takes_energy_damage.emit(energy_usage_while_climbing);
		if (is_watering):
		# Move the character
			velocity = direction * speed * speed_multiplier * jet_propulsion_multiplier;
		else:
			velocity = direction * speed * speed_multiplier;
		move_and_slide();

		# Play the animation
		if not player_sprite.is_playing():
			player_sprite.play("move");
	else:
		if !(Globals.check_if_player_has_build_on(Enums.build_ons.MECHANICAL_ARM)):
			Events.player_takes_energy_damage.emit(energy_usage_while_still);
		player_sprite.pause();
		
func _handle_cutscene(cutscene_type: Enums.cutscene_type):
	self.in_cutscene = true;
	if (cutscene_type == Enums.cutscene_type.CLIMB_UP):
		var tile_generator: TileMapGenerator = get_tree().get_first_node_in_group(NodeGroups.tile_generator);
		player_sprite.play("move");
		var next_position: Vector2 = Vector2((tile_generator.climbable_width * Globals.pixel_size / 2), ( -1 * tile_generator.climbable_height * Globals.pixel_size) - 4);
		
		var move_to_top_time: float = 0.75;
		var move_to_ranger_station_time: float = 2;
		var time_buffer: float = 0.25;
		var victory_time: float = 8;
		var wait_until_build_ons_shown: float = 2.5;
		
		var movement_tween: Tween = create_tween();
		print("current position: " + str(self.global_position) );
		print("moving to: " + str(next_position) + "\n");
		movement_tween.tween_property(self, "global_position", next_position, (move_to_top_time)).from_current();
		await get_tree().create_timer(move_to_top_time).timeout;
		player_sprite.stop();
		movement_tween.stop();
		await get_tree().create_timer(0.2).timeout;
		player_sprite.play("victory");
		Events.play_victory_jingle.emit();
		await get_tree().create_timer(5).timeout;
		if (Globals.current_level < 5):
			Events.create_build_on_choices.emit();
			next_position = Vector2(self.global_position.x + (Globals.pixel_size*5) , self.global_position.y)
			var move_left_tween: Tween = create_tween();
			
			Events.fade_to_black.emit();
			
			player_sprite.play("walk");
			move_left_tween.tween_property(self, "global_position", next_position, (move_to_ranger_station_time));
			await get_tree().create_timer(move_to_ranger_station_time + time_buffer).timeout;
			move_left_tween.stop();
			player_sprite.stop();
			
			await get_tree().create_timer(wait_until_build_ons_shown).timeout;
			Events.show_build_on_options.emit();
			Events.reset_player_to_origin.emit();
		else:
			water_particles.emitting = true;
			water_particles.position = Vector2(water_particles.position.x, water_particles.position.y - 4)
			water_particles.amount = water_particles.amount * 10;
			water_particles.lifetime = water_particles.lifetime * 3;
			water_particles.scale = water_particles.scale * 3;
			await get_tree().create_timer(3).timeout;
			Events.wash_away.emit();
			await get_tree().create_timer(3).timeout;
			get_tree().change_scene_to_file("res://UI/victory_screen/victory_screen.tscn");
		
	if (cutscene_type == Enums.cutscene_type.LEAVE_STATION):
		self.in_cutscene = true;
		Events.set_station_to_back.emit();
		var tile_generator: TileMapGenerator = get_tree().get_first_node_in_group(NodeGroups.tile_generator);
		
		Events.fade_from_black.emit();
		player_sprite.play("walk");
		var next_position: Vector2 = Vector2((tile_generator.climbable_width * Globals.pixel_size / 2), self.global_position.y);
		
		var walk_time: float = 2;
		var pause_time: float = 0.25;
		
		var movement_tween: Tween = create_tween();
		print("current position: " + str(self.global_position) );
		print("moving to: " + str(next_position) + "\n");
		movement_tween.tween_property(self, "global_position", next_position, (walk_time)).from_current();
		await get_tree().create_timer(walk_time).timeout;
		await get_tree().create_timer(pause_time).timeout;
		movement_tween.stop();
		player_sprite.play("default");
		player_sprite.stop();
		_add_approval_to_energy();
		
		Events.set_station_to_front.emit();
		Events.start_fires.emit();
		Events.restore_energy.emit();
		self.in_cutscene = false;
		Events.play_main_theme.emit();
		

func _on_reset_player_to_ranger_station():
	self.global_position = Vector2(212, -12);


func _on_water_nozzle_area_area_entered(area: Area2D) -> void:
	if (area is Hazard && is_watering):
		Events.dowse_hazard_tile.emit(area.hazard_list_index);
			


func _on_solar_battery_timer_timeout() -> void:
	self.current_energy += 50;

func _add_approval_to_energy():
	var player: Player = get_tree().get_first_node_in_group(NodeGroups.player);

	var approval_increase = player.energy_capacity * (approval_bar.current_approval / approval_bar.total_approval);
	if (energy_bar.value + approval_increase > player.energy_capacity):
		energy_bar.value = player.energy_capacity;
	else:
		energy_bar.value = energy_bar.value + approval_increase;
