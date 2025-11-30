extends Node2D

@export var PauseMenu:pauseMenu
@export var smoking:Node2D
@export var timer:Timer
@export var black:Node2D



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
		PermanentGlobal.deleted = SaveLoad.SaveFileData.deleted
		PermanentGlobal.watercoolers = SaveLoad.SaveFileData.watercoolers
	
#func _process(delta: float) -> void:
	#if Input.is_action_pressed("smoking")&&timer.is_stopped():
		#if smoking.visible == true:
			#smoking.visible = false
			#timer.start()
		#else:
			#smoking.visible = true
			#timer.start()
	

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()



func _on_wishlist_pressed() -> void:
	OS.shell_open("https://store.steampowered.com/app/3554030/Behind_the_Hydras_Eyes")


func _on_credits_pressed() -> void:
	Fader.FadeUp("Credits")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/EndOfDemo.tscn")
	Fader.FadeDown("Credits")




func _on_options_pressed() -> void:
	PauseMenu.openPause()


func _on_new_game_pressed() -> void:
	Fader.FadeUp("The Game Saves automatically at the start of each Day")
	await Fader.fade_finished
	black.visible = true
	await get_tree().create_timer(1.0).timeout
	Fader.FadeDown("The Game Saves automatically at the start of each Day")
	await Fader.fade_finished
	Fader.FadeUp("First Day")
	await Fader.fade_finished
	PermanentGlobal.reset_choices()
	Dialogic.VAR.clear_game_state()
	Dialogic.VAR.CurrentQuarter = "Quarter1"
	black.visible = false
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
	Fader.FadeDown("First Day")
