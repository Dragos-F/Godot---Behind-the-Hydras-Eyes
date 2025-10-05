extends Node2D
@export var BossTextAnchor:Node2D
@export var daveAnim:AnimatedSprite2D
@export var train_sound:AudioStreamPlayer2D
@onready var originalBackVol:float
@export var PauseMenu:Node2D
@export var TimelineToStart:String

func _ready() -> void:
	Dialogic.timeline_ended.connect(end_scene)
	originalBackVol = AudioBrain.BackPlayer.volume_db 
	AudioBrain.fadeBetween(AudioBrain.BackPlayer, originalBackVol - 24,train_sound,originalBackVol)

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()

func _on_timer_timeout() -> void:
	daveAnim.play("phone_up")
	print ("PhoneUp Started")
	var layout = Dialogic.start(TimelineToStart)
	if TimelineToStart == "Text From Boss":
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Text From Boss.dch",BossTextAnchor)
	
	


func end_scene():
	Dialogic.timeline_ended.disconnect(end_scene)
	daveAnim.play("phone_down")
	AudioBrain.fadeBetween(train_sound, -80,AudioBrain.BackPlayer,originalBackVol)
	Fader.FadeUp("Forward Green Office")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/Day1.tscn")
	Fader.FadeDown("Forward Green Office")
	
