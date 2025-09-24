extends AnimatedSprite2D

var bag = preload("res://Scenes/tea_bag.tscn")
@export var minigame:minigame_brain


func getBag():
	var teabag = bag.instantiate()
	add_child(teabag)
	minigame.holding = true

func _on_tea_box_mouse_entered() -> void:
	play("open")
	


func _on_tea_box_mouse_exited() -> void:
	play_backwards("close")



func _on_tea_box_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed()\
		and !minigame.holding:
			getBag()
			minigame.holding = true
			
		
