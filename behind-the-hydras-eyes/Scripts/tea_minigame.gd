extends Node2D
class_name minigame_brain

@export var holding:bool = false



func _on_button_pressed() -> void:
	Fader.FadeUp("Office")
	await Fader.fade_finished
	self.visible = false
	Fader.FadeDown("Office")
