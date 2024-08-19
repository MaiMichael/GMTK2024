extends Node2D


var body: Array[CharacterBody2D] = []
var body_piece = preload("res://scenes/snek_body.tscn")

@onready var head = get_node("snek_head")

func _ready():
	body.append(get_node("PinJoint2D/snek_body"))


func _on_snek_head_grow():
	var last_piece = body.back()
	
	var new_joint = PinJoint2D.new()
	new_joint.global_position = last_piece.global_position - 11
	
	var new_body_piece = body_piece.instantiate()
	new_body_piece.global_position = last_piece.global_position - 22
	
	new_joint.node_a = last_piece
	new_joint.node_b = new_body_piece
	
	new_joint.add_child(new_body_piece)
	add_child(new_joint)
	


func _on_timer_timeout():
	var last_piece = body.back()
	
	var new_joint = PinJoint2D.new()
	new_joint.global_position = last_piece.global_position - 11
	
	var new_body_piece = body_piece.instantiate()
	new_body_piece.global_position = last_piece.global_position - 22
	
	new_joint.node_a = last_piece
	new_joint.node_b = new_body_piece
	
	new_joint.add_child(new_body_piece)
	add_child(new_joint)
