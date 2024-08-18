extends StaticBody2D

@export var is_vertical: bool = true;
@export var starting_vector: Vector2 = Vector2(0,0);
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position = starting_vector;
	var collision_shape: CollisionShape2D = self.get_child(0);
	if (is_vertical):
		collision_shape.scale.y = 5000000000;
	else:
		collision_shape.scale.x = 5000000000;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
