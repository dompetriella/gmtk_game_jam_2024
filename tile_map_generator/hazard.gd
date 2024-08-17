class_name Hazard
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var hazard_list_index: int;
var hazard_coordinate: Vector2;
var is_on_fire: bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_animated_sprite(sprite: SpriteFrames):
	animated_sprite_2d.sprite_frames = sprite;
	animated_sprite_2d.play();
