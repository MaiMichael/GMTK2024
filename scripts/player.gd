extends CharacterBody2D

@export var base_mvm_speed = 8
@export var scaling_speed = 10.0
@export var max_size = 5

var last_spawn_position = self.global_position
var direction
var can_control = true

#---------------------------------------------------------------------------------------------

@onready var anim = $AnimatedSprite2D

var blob_splash = preload("res://scenes/blob_splash.tscn")


func _ready():
	anim.play("idle")
	
func _process(delta):
	if(global_scale.x <= 0.15):
		handle_death()

func _physics_process(delta):
	if(can_control):
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		spawn_puddle()
		move()

func move():
	velocity = direction * calculate_speed()
	move_and_slide()
	
func spawn_puddle():
	var distance = 16 * scale.x
	if(global_position.x - last_spawn_position.x >= distance || 
	global_position.y - last_spawn_position.y >= distance ||
	global_position.x - last_spawn_position.x <= -distance ||
	global_position.y - last_spawn_position.y <= -distance):
		var blob_splash_instance = blob_splash.instantiate()
		blob_splash_instance.global_position = last_spawn_position
		blob_splash_instance.global_scale = self.global_scale
		$"../BlobSplashManager".add_child(blob_splash_instance)
		last_spawn_position = self.global_position

func _on_area_2d_body_entered(body):
	if body.has_method("get_eaten"):
		body.get_eaten()
		grow_size()

func grow_size():
	if(global_scale.x >= max_size):
		return
	global_scale.x += 0.2
	global_scale.y += 0.2

func calculate_speed()->int:
	return base_mvm_speed/(global_scale.x * scaling_speed)

func _on_timer_timeout():
	global_scale.x -= 0.05
	global_scale.y -= 0.05

func take_damage():
	anim.modulate = Color.BLACK
	global_scale.x -= 0.1
	global_scale.y -= 0.1
	await get_tree().create_timer(1.0).timeout
	anim.modulate = Color.WHITE
	
func handle_death():
	visible = false
	can_control = false
	
	get_tree().reload_current_scene()
