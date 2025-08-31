extends Sprite2D

var cube = preload("res://Scenes/cube.tscn")




			
func getCube():
	var sugarcube  = cube.instantiate()
	add_child(sugarcube)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed():
			getCube()
