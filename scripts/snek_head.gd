extends CharacterBody2D

@export var base_mvm_speed = 16
var current_position = [0,0]

var last_spawn_position = self.global_position
var new_direction
var movement_direction = Vector2(1,0)

signal grow

#---------------------------------------------------------------------------------------------

@onready var sprite = $Sprite2D

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var vel : Vector2 = get_global_mouse_position() - global_position
	velocity = vel
	move_and_slide()
	#handle_sprite_direction()
	#move()

func move():
	var tween = create_tween()
	tween.tween_property(self, "position", position + movement_direction * base_mvm_speed, 0.35)
	if new_direction:
		movement_direction = new_direction
		
		
func handle_sprite_direction():
	if movement_direction == Vector2(1,0):
		sprite.global_rotation_degrees = 90
	if movement_direction == Vector2(-1,0):
		sprite.global_rotation_degrees = -90
	if movement_direction == Vector2(0,1):
		sprite.global_rotation_degrees = 180
	if movement_direction == Vector2(0,-1):
		sprite.global_rotation_degrees = 0

func _on_area_2d_body_entered(body):
	if body.has_method("get_eaten"):
		body.get_eaten()
		grow.emit()

func calculate_speed()->int:
	return base_mvm_speed/global_scale.x
