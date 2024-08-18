class_name Hazard
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var hazard_list_index: int;
var hazard_coordinate: Vector2;
var is_on_fire: bool = false;

func _ready():
	Events.dowse_hazard_tile.connect(_dowse_hazard_tile);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_animated_sprite(sprite: SpriteFrames):
	animated_sprite_2d.sprite_frames = sprite;
	if (sprite != null):
		animated_sprite_2d.play();

func _dowse_hazard_tile(tile_id: int):
	if (hazard_list_index == tile_id):
		is_on_fire = false;
		set_animated_sprite(null);
		var hazard_children: Array[Node] = self.get_children();
		for child in hazard_children:
			if (child is Timer):
				child.stop();


func _on_body_entered(body: Node2D) -> void:
	if (body is Player && is_on_fire):
		print('ouch!');
