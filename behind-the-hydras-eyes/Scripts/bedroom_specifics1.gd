extends Node
@export var balcony_notif: Node2D
@export var computer_notif:Node2D




func _on_balcony_interacted() -> void:
	balcony_notif.visible = false
	


func _on_computer_interacted() -> void:
	computer_notif.visible = false
