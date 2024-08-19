extends Node2D

@export var enemy = preload("res://scenes/enemy_villager.tscn")

var player_position 

func _process(delta):
	player_position = get_node("/root/Game/Player").global_position
	global_position = player_position

func spawn_enemy():
	var new_enemy = enemy.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	$"/root/Game".add_child(new_enemy)


func _on_timer_timeout():
	spawn_enemy()
