extends Sprite2D

var cube = preload("res://Scenes/cube.tscn")
@export var cubeParent:Node2D
@export var minigame:minigame_brain


			
func getCube():
	var sugarcube  = cube.instantiate()
	cubeParent.add_child(sugarcube)
	minigame.holding = true
	#sugarcube.z_as_relative = false
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed():
			getCube()
