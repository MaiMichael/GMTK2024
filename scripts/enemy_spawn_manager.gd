extends Node2D

@export var enemy = preload("res://scenes/enemy_villager.tscn")
var difficulty_timer = CountTime.timer
var difficulty_incremented = false
var player_position 
var can_spawn = true

func _physics_process(delta):
	difficulty_timer = CountTime.timer
	if CountTime.timer == 150 || CountTime.timer == 320:
		can_spawn = false
		$Timer.wait_time = 2
		can_spawn = true
		
	if difficulty_timer%40 == 0 && !difficulty_incremented:
		difficulty_incremented = true
		print_debug("I'm increasing difficulty!")
		print_debug(difficulty_timer)
		$Timer.wait_time -= 0.4
		
	if difficulty_timer%40 != 0 && difficulty_incremented:
		difficulty_incremented = false;
		
	player_position = get_node("/root/Game/Player").global_position
	global_position = player_position

func spawn_enemy():
	if can_spawn:
		var new_enemy = enemy.instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_enemy.global_position = %PathFollow2D.global_position
		$"/root/Game".add_child(new_enemy)
	
func _on_timer_timeout():
	spawn_enemy()
