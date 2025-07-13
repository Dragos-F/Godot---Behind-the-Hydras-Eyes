extends Node2D


func _on_start_pressed() -> void:
	Fader.FadeUp("First Day")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
	Fader.FadeDown("First Day")
	





func _on_wishlist_pressed() -> void:
	OS.shell_open("https://store.steampowered.com/app/3554030/Behind_the_Hydras_Eyes")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/EndOfDemo.tscn")

func on_quit_pressed() -> void:
	get_tree().quit()
