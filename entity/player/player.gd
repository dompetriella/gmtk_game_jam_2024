class_name Player
extends CharacterBody2D


@export var speed = 300.0;
@export var energy_capacity: float = 1000; 
@export var energy_usage_while_climbing: float = 8;
@export var energy_usage_while_still: float = 2;
@export var energy_usage_while_dowsing: float = 12;
@export var energy_usage_rate: float = 100;

@onready var water_nozzle_area: Area2D = $WaterNozzleArea
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var water_particles: GPUParticles2D = $WaterNozzleArea/GPUParticles2D

var direction: Vector2 = Vector2.ZERO
var is_watering: bool = false;
var current_energy: float = energy_capacity;

func _ready() -> void:
	self.global_position = Vector2(16 * 9, -16);
	water_particles.emitting = false;
	Events.player_takes_energy_damage.connect(func(energy_damage):
		current_energy = current_energy - (energy_damage / (500-energy_usage_rate));
	);

func _process(delta: float):
	handle_input();
	move_and_animate(delta);
	_handle_watering();
	
func _handle_watering():
		if Input.is_action_pressed("ui_select"):
			is_watering = true;
			await get_tree().create_timer(0.1).timeout;
			water_particles.emitting = true;
			Events.player_takes_energy_damage.emit(energy_usage_while_dowsing);
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
		Events.player_takes_energy_damage.emit(energy_usage_while_climbing);
		# Move the character
		velocity = direction * speed
		move_and_slide();

		# Play the animation
		if not player_sprite.is_playing():
			player_sprite.play("move");
	else:
		Events.player_takes_energy_damage.emit(energy_usage_while_still);
		player_sprite.pause();

func _on_water_nozzle_area_area_entered(area: Area2D) -> void:
	if (area is Hazard && is_watering):
		Events.dowse_hazard_tile.emit(area.hazard_list_index);
			
