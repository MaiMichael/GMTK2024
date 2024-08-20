extends Camera2D

@export var follow_speed = 5.0
@onready var player = $"../Player"

func _physics_process(delta):
	position = lerp(position, player.position, follow_speed * delta)
