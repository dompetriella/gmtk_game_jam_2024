extends CharacterBody2D


@export var speed = 300.0;

@onready var water_nozzle_area: Area2D = $WaterNozzleArea
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO
var is_watering: bool = false;

func _ready() -> void:
	self.global_position = Vector2(16 * 9, 0);

func _process(delta: float):
	handle_input();
	move_and_animate(delta);
	_handle_watering();
	
func _handle_watering():
		if Input.is_action_pressed("ui_select"):
			is_watering = true;
			water_nozzle_area.visible = true;
			print('oh he watering');
		else:
			is_watering = false;
			water_nozzle_area.visible = false;
	
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
		# Move the character
		velocity = direction * speed
		move_and_slide();

		# Play the animation
		if not player_sprite.is_playing():
			player_sprite.play("move");
	else:
		player_sprite.pause();


func _on_water_nozzle_area_area_entered(area: Area2D) -> void:
	if (area is Hazard):
		if (area.is_on_fire && is_watering):
			area.is_on_fire = false;
			area.animated_sprite_2d.sprite_frames = null;
			var hazard_children = area.get_children();
			for child in hazard_children:
				if (child is Timer):
					child.stop();
