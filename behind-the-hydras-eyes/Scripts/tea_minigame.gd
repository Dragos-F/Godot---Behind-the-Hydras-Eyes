extends Node2D
class_name minigame_brain
@onready var PauseMenu: pauseMenu = %Pause
@export var holding:bool = false
@export var mugs:Array[mugBrain]
@export var AlexAnchor:Node2D
@export var JenAnchor:Node2D


#
#func _input(event):
	##if event.is_action_pressed("menu"):
		##if !PauseMenu.visible:
			##PauseMenu.openPause()
		##elif PauseMenu.visible:
			##PauseMenu.closePause()

func _on_button_pressed() -> void:
	Fader.FadeUp("Office")
	await Fader.fade_finished
	for i in mugs:
		i.reset()
		print("Mug Reset")
	self.visible = false
	Fader.FadeDown("Office")
	if Dialogic.VAR.TeaForTeam == true:
		var layout = Dialogic.start("GiveTea")
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Alex.dch",AlexAnchor)
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Jen.dch",JenAnchor)


func _on_reset_pressed() -> void:
	for i in mugs:
		i.reset()
