extends RigidBody2D

@onready var head = get_node("../snek_head")

func _on_area_2d_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage()
