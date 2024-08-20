extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var audio_player = $AudioStreamPlayer2D

var fading = true

func _ready():
	audio_player.play()
	anim.play()
	
func _process(_delta):
	global_rotation = 0.0

func _on_timer_timeout():
	if fading:
		queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage()
