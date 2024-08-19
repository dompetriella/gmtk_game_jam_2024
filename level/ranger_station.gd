extends Area2D

func _ready() -> void:
	Events.set_station_to_back.connect(func():
		self.z_index = 98;	
	)
	Events.set_station_to_front.connect(func():
		self.z_index = 100;	
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Globals.current_level == 1):
		visible = false;
	else:
		visible = true;
