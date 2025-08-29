extends Node2D

@export var PauseMenu:pauseMenu
@export var message:Control


func _on_start_pressed() -> void:
	#Fader.FadeUp("First Day")
	#await Fader.fade_finished
	#get_tree().change_scene_to_file("res://Scenes/train.tscn")
	#Fader.FadeDown("First Day")
	message.visible = true
	

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()



func _on_wishlist_pressed() -> void:
	OS.shell_open("https://store.steampowered.com/app/3554030/Behind_the_Hydras_Eyes")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/EndOfDemo.tscn")

func on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	PauseMenu.openPause()


func _on_message_okay_pressed() -> void:

	Fader.FadeUp("First Day")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
	Fader.FadeDown("First Day")
