extends Node2D
@onready var minigame:minigame_brain = get_node("/root/TeaMinigame")

	


func _physics_process(_delta: float) -> void:
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position",target,0.3)
		self.z_index = 2
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			self.queue_free()
			minigame.holding = false
			
