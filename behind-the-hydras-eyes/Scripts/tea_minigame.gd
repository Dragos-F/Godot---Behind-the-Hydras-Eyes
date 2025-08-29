extends Node2D




func _on_button_pressed() -> void:
	Fader.FadeUp("Office")
	await Fader.fade_finished
	self.visible = false
	Fader.FadeDown("Office")
