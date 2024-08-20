extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.play_main_theme.connect(
		func():
			var main_theme = load("res://assets/music/FRRR_main_theme4.mp3");
			self.stop();
			self.stream = main_theme;
			self.play();
	);
	Events.play_victory_jingle.connect(
		func():
			var victory_jingle = load("res://assets/music/victory_jingle.mp3");
			self.stop();
			self.stream = victory_jingle;
			self.play();
	);
