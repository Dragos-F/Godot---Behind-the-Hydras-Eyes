extends Node2D
@export var BossTextAnchor:Node2D
@export var daveAnim:AnimatedSprite2D
@export var train_sound:AudioStreamPlayer2D

func _ready() -> void:
	Dialogic.timeline_ended.connect(end_scene)
	AudioBrain.fadeBetween(AudioBrain.BackPlayer,-24,train_sound,0)


func _on_timer_timeout() -> void:
	daveAnim.play("phone_up")
	print ("PhoneUp Started")
	var layout = Dialogic.start("Text From Boss")
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Text From Boss.dch",BossTextAnchor)
	
	
func end_scene():
	Dialogic.timeline_ended.disconnect(end_scene)
	daveAnim.play("phone_down")
	AudioBrain.fadeBetween(train_sound, -80,AudioBrain.BackPlayer,0)
	Fader.FadeUp("Forward Green Office")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/Day1.tscn")
	Fader.FadeDown("Forward Green Office")
	
