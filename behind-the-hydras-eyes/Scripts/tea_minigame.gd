extends Node2D
class_name minigame_brain
@export var PauseMenu:pauseMenu
@export var holding:bool = false
@export var mugs:Array[mugBrain]

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()

func _on_button_pressed() -> void:
	Fader.FadeUp("Office")
	await Fader.fade_finished
	for i in mugs:
		i.reset()
		print("Mug Reset")
	self.visible = false
	Fader.FadeDown("Office")
