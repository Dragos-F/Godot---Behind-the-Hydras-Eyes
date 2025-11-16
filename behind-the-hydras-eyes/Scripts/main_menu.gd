extends Node2D

@export var PauseMenu:pauseMenu


func _on_start_pressed() -> void:
	
	if FileAccess.file_exists(SaveLoad.save_location):
		Fader.FadeUp("Last you were here...")
		await Fader.fade_finished
		SaveLoad._load()
		print (SaveLoad.SaveFileData.lastScene)
		var scene_to_load:String = SaveLoad.SaveFileData.lastScene
		get_tree().change_scene_to_file(scene_to_load)
		Fader.FadeDown("Last you were here...")
		PermanentGlobal.LocationChoice = SaveLoad.SaveFileData.location_choice
		PermanentGlobal.Lifestyle = SaveLoad.SaveFileData.Lifestyle
		PermanentGlobal.Savings = SaveLoad.SaveFileData.Savings
		PermanentGlobal.email_choices = SaveLoad.SaveFileData.email_choices.duplicate(true)
	
	
	

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




func _on_options_pressed() -> void:
	PauseMenu.openPause()


func _on_new_game_pressed() -> void:
	Fader.FadeUp("First Day")
	await Fader.fade_finished
	PermanentGlobal.reset_choices()
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
	Fader.FadeDown("First Day")
