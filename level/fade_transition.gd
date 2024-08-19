extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false;
	Events.fade_to_black.connect(_fade_to_black);
	Events.fade_from_black.connect(_fade_from_black);
	Events.wash_away.connect(_wash_away);

func _fade_to_black():
	self.visible = true;
	animation_player.play("fade_to_black");

func _fade_from_black():
	animation_player.play("fade_from_black");
	animation_player.animation_finished.connect(func(): self.visible = false);

func _wash_away():
	self.visible = true;
	animation_player.play("wash_away");
