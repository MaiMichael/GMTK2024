extends CharacterBody2D

@export var mvm_speed = 200
@export var health = 100
@export var damage = 10

@onready var player = get_node("/root/Game/Player")
@onready var enemy_spawn_manager = get_node("/root/Game/EnemySpawnManager")
@onready var skelly = preload("res://scenes/skelly.tscn")
@onready var damage_numbers_origin = $DamageNumberOrigin

func _process(delta):
	if health <= 0:
		var skelly_instance = skelly.instantiate()
		skelly_instance.global_position = global_position
		$"/root/Game".add_child(skelly_instance)
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

	
