extends CharacterBody2D

@export var base_mvm_speed = 8
@export var scaling_speed = 10.0
@export var max_size = 8
@export var size_to_jump = 4.0
@export var size_to_ascend = 8

var last_spawn_position = self.global_position
var direction
var can_control = true
var is_jumping = false
var circle
var circle_active = false
var circle_spawn_positions = PackedVector2Array([Vector2(0,-45),Vector2(35,-34),Vector2(44.5,0),
Vector2(0,45),Vector2(35,34),
Vector2(-35,34),Vector2(-44.5,0),
Vector2(-35,-34)])

#---------------------------------------------------------------------------------------------

@onready var anim = $AnimatedSprite2D
@onready var big = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var audio = $AudioStreamPlayer2D

var blob_splash = preload("res://scenes/blob_splash.tscn")

func _ready():
	anim.play("idle")
	animation_player.play("idle")
	
func _process(delta):
	if(global_scale.x <= 0.15):
		handle_death()

func _physics_process(delta):
	if(can_control):
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		if(global_scale.x < size_to_jump):
			spawn_line_fire()
			move()
		elif (global_scale.x >= size_to_jump):
			jump()

func move():
	velocity = direction * calculate_speed()
	move_and_slide()

func fly():
	velocity = direction * base_mvm_speed
	move_and_slide()
	
func jump():
	if direction:
		if is_jumping == false:
			is_jumping = true
			animation_player.play("jump")
			var tween = create_tween()
			tween.tween_property(self, "position", position + direction * base_mvm_speed, 1.4)
			tween.tween_callback(is_jumping_false)
			await get_tree().create_timer(1.4).timeout
			spawn_circle_fire()
			animation_player.play("idle")
			
func is_jumping_false():
	is_jumping = false
	
func spawn_line_fire():
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

func spawn_circle_fire():
	for pos in circle_spawn_positions:
		var blob_splash_instance = blob_splash.instantiate()
		blob_splash_instance.global_scale = self.global_scale
		$"../BlobSplashManager".add_child(blob_splash_instance)
		blob_splash_instance.global_position = global_position + pos
		

func _on_area_2d_body_entered(body):
	if body.has_method("get_eaten"):
		body.get_eaten()
		grow_size()

func grow_size():
	if(global_scale.x >= max_size):
		return
	if(global_scale.x >= size_to_jump):
		big.visible = true
		anim.visible = false
	global_scale.x += 0.15
	global_scale.y += 0.15

func calculate_speed()->int:
	var current_speed = base_mvm_speed
	return current_speed/(global_scale.x * scaling_speed)

func _on_timer_timeout():
	global_scale.x -= 0.05
	global_scale.y -= 0.05
	if (global_scale.x < size_to_jump):
		big.visible = false
		anim.visible = true

func take_damage():
	audio.play()
	anim.modulate = Color.BLACK
	big.modulate = Color.BLACK
	global_scale.x -= 0.1
	global_scale.y -= 0.1
	await get_tree().create_timer(1.0).timeout
	anim.modulate = Color.WHITE
	big.modulate = Color.WHITE
	if (global_scale.x < size_to_jump):
		big.visible = false
		anim.visible = true
	
func handle_death():
	visible = false
	can_control = false
	CountTime.timer = 0
	
	get_tree().reload_current_scene()
