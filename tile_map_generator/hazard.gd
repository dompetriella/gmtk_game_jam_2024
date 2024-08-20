class_name Hazard
extends Area2D

enum HazardType {FIRE, BRAMBLE, ENEMY}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var hazard_list_index: int;
var hazard_coordinate: Vector2;
var is_on_fire: bool = false;
var is_finishing_tile: bool = false;

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
		Events.adjust_approval.emit(4);


func _on_body_entered(body: Node2D) -> void:
	if (body is Player && is_on_fire):
		print('ouch!');
		Events.sfx2_play.emit("res://assets/audio/sfx/hit-by-fire.mp3");
		var energy_rate: float = body.energy_usage_rate;
		if !(Globals.check_if_player_has_build_on(Enums.build_ons.FIREPROOF_CHASSIS)):
			Events.player_takes_energy_damage.emit(50 * energy_rate);
		if (Globals.check_if_player_has_build_on(Enums.build_ons.SMOTHER_BLANKET)):
			Events.dowse_hazard_tile.emit(hazard_list_index);
	if (body is Player && is_finishing_tile):
		Events.player_enter_cutscene.emit(Enums.cutscene_type.CLIMB_UP);
