extends Node2D

@onready var pause_menu_screen = $FollowCamera/PauseMenu

var paused = false
var timer = 0

func _ready():
	pause_menu_screen.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()
		
func pause_menu():
	if paused:
		pause_menu_screen.hide()
		Engine.time_scale = 1
	else:
		pause_menu_screen.show()
		Engine.time_scale = 0
	
	paused = !paused
