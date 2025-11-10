extends Area2D

@export var container:containerPour


func _on_mouse_entered() -> void:
	container.base_return = true


func _on_mouse_exited() -> void:
	container.base_return = false
	
