extends Sprite2D
@export var folder:Sprite2D

func _on_start_mouse_entered() -> void:
	folder.visible = true
	self.scale = 2.05*Vector2.ONE

func _on_start_mouse_exited() -> void:
	folder.visible = false
	self.scale = 2*Vector2.ONE
