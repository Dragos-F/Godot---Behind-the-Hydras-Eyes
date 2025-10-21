extends Node2D

@export var dave:agentScript
var target:Vector2
var move_cooldown:bool = false
@export var timer:Timer

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed() \
		and !move_cooldown \
		and Dialogic.current_timeline == null:
			target = get_global_mouse_position()
			await get_tree().physics_frame
			dave.set_movement_target(target)
			move_cooldown = true
			timer.start()
			


func _on_timer_timeout() -> void:
	move_cooldown = false
	
