extends AnimatedSprite2D


@export_enum("Doc","Cat","Update","Knocks","Love","Smoking","Vacuum") var anim:String
@export var PopUp:Control


func _ready() -> void:
	self.play(anim)


func _on_button_pressed() -> void:
	PopUp.visible = true


func _on_close_pressed() -> void:
	PopUp.visible = false
