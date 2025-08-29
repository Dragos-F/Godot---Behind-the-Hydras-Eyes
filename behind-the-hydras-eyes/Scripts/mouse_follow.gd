extends Node2D

func _physics_process(_delta: float) -> void:
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position",target,0.3)
		self.z_index = 2
