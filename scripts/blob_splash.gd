extends Area2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play()

func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage()
