extends Node2D


func _on_start_pressed() -> void:
	Fader.FadeUp("First Day")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
	Fader.FadeDown("First Day")
	
