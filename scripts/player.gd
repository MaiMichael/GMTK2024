extends CharacterBody2D

var tile_size = 16

var moving = false
var last_position = self.global_position
var direction

@onready var anim = $AnimatedSprite2D

var blob_splash = preload("res://scenes/blob_splash.tscn")

func _ready():
	anim.play("idle")

func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	move()
	

func move():
	if direction:
		if moving == false:
			moving = true
			last_position = self.global_position
			var blob_splash_instance = blob_splash.instantiate()
			blob_splash_instance.global_position = last_position
			$"/root/Game/BlobSplashManager".add_child(blob_splash_instance)
			var tween = create_tween()
			tween.tween_property(self,"position",position + direction * tile_size, 0.35)
			tween.tween_callback(move_false)

func move_false():
	moving = false
