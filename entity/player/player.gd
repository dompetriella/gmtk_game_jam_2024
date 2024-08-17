extends CharacterBody2D


@export var speed = 300.0;

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	self.global_position = Vector2(16 * 9, 0);

func _process(delta: float):
	handle_input();
	move_and_animate(delta);

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
