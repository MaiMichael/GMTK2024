extends CharacterBody2D

@export var mvm_speed = 200

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = -direction * mvm_speed
	move_and_slide()

func get_eaten():
	queue_free()
