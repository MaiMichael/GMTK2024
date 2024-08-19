extends CharacterBody2D

@export var base_mvm_speed = 32

var last_spawn_position = self.global_position
var direction

#---------------------------------------------------------------------------------------------

@onready var anim = $AnimatedSprite2D

var blob_splash = preload("res://scenes/blob_splash.tscn")

func _ready():
	anim.play("idle")

func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	spawn_puddle()
	move()

func move():
	velocity = direction * calculate_speed()
	move_and_slide()
	
func spawn_puddle():
	var distance = 32 * scale.x
	if(global_position.x - last_spawn_position.x >= distance || 
	global_position.y - last_spawn_position.y >= distance ||
	global_position.x - last_spawn_position.x <= distance ||
	global_position.y - last_spawn_position.y <= distance):
		var blob_splash_instance = blob_splash.instantiate()
		blob_splash_instance.global_position = last_spawn_position
		blob_splash_instance.global_scale = global_scale
		$"../BlobSplashManager".add_child(blob_splash_instance)
		last_spawn_position = self.global_position

func _on_area_2d_body_entered(body):
	if body.has_method("get_eaten"):
		body.get_eaten()
		grow_size()

func grow_size():
	anim.global_scale.x += 1
	anim.global_scale.y += 1

func calculate_speed()->int:
	return base_mvm_speed/global_scale.x

func _on_timer_timeout():
	anim.global_scale.x -= 0.1
	anim.global_scale.y -= 0.1
