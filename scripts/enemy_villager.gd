extends CharacterBody2D

var mvm_speed = 200
var health = 100
var damage = 10

@onready var player = get_node("/root/Game/Player")
@onready var damage_numbers_origin = $DamageNumberOrigin

func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mvm_speed
	move_and_slide()

func take_damage():
	get_node("Sprite2D").modulate = Color.FIREBRICK
	DamageNumbers.display_number(damage, damage_numbers_origin.global_position)
	health -= damage;
	await get_tree().create_timer(1.0).timeout
	get_node("Sprite2D").modulate = Color.WHITE

	
