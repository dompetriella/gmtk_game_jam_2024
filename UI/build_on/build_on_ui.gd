extends Control

@onready var texture_rect: TextureRect = $TextureRect


var texture: Texture2D;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = texture;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
