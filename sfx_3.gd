extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.sfx3_play.connect(
		func(sound_path):
			var sound = load(sound_path);
			self.stop();
			self.stream = sound;
			self.play();
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
