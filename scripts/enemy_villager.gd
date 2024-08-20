extends CharacterBody2D

var nova = false
var last_nova = false
@export var mvm_speed = 200
@export var health = 100
@export var damage = 10

@onready var player = get_node("/root/Game/Player")
@onready var enemy_spawn_manager = get_node("/root/Game/EnemySpawnManager")
@onready var skelly = preload("res://scenes/skelly.tscn")
@onready var damage_numbers_origin = $DamageNumberOrigin
@onready var audio = $AudioStreamPlayer2D

func _process(delta):
	if CountTime.timer >= 140:
		$Sprite2D.frame = 87
		mvm_speed = 48
		damage = 10
	
	if CountTime.timer >= 300:
		$Sprite2D.frame = 96
		mvm_speed = 64
		damage = 5
		
		
	if health <= 0:
		process_death()

func process_death():
	var skelly_instance = skelly.instantiate()
	skelly_instance.global_position = global_position
	$"/root/Game".add_child(skelly_instance)
	queue_free()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mvm_speed
	move_and_slide()

func take_damage():
	audio.play()
	get_node("Sprite2D").modulate = Color.FIREBRICK
	DamageNumbers.display_number(damage, damage_numbers_origin.global_position)
	health -= damage;
	await get_tree().create_timer(1.0).timeout
	get_node("Sprite2D").modulate = Color.WHITE

	

func _on_area_2d_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage()
