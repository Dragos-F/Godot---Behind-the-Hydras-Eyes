extends AnimatedSprite2D

var bag = preload("res://Scenes/tea_bag.tscn")



func getBag():
	var teabag = bag.instantiate()
	add_child(teabag)

func _on_tea_box_mouse_entered() -> void:
	play("open")
	


func _on_tea_box_mouse_exited() -> void:
	play_backwards("open")



func _on_tea_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed():
			getBag()
		
