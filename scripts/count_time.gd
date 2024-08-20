extends CanvasLayer

var time = CountTime.timer

func _physics_process(delta):
	time = float(time) + delta
	
	update_ui()
	
func update_ui():
	var formatted_time = str(int(time))
	#var decimal_index = formatted_time.find(".")
	
	#if decimal_index < 0:
		#formatted_time = formatted_time.left(decimal_index + 3)
		
	CountTime.timer = formatted_time
	
	$Label.text = formatted_time
