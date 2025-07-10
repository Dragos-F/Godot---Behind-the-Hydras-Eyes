extends Node2D


func _on_timer_timeout() -> void:
	Fader.FadeUp("Forward Green Office")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/Day1.tscn")
	Fader.FadeDown("Forward Green Office")
	
