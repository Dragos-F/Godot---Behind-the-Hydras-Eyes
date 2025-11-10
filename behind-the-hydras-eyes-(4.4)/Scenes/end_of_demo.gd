extends Node2D
@export var PauseMenu:Node2D

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()


func _on_main_menu_pressed() -> void:
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	Fader.FadeDown("")
