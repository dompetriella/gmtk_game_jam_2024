extends CharacterBody2D


@export var speed = 300.0


func _physics_process(delta: float) -> void:

	self.velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized() * speed;
	self.move_and_slide();

	move_and_slide()
