extends Node2D
@export var BackPlayer: AudioStreamPlayer2D
@export var UIsfxPlayer :AudioStreamPlayer2D
@export var FXPlayer:AudioStreamPlayer2D
@export var RandFXPlayer:AudioStreamPlayer2D
@export var RandFXStream:AudioStreamRandomizer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") && Dialogic.current_timeline !=null:
		UIsfxPlayer.play()
	if !BackPlayer.playing:
		BackPlayer.play()
func fadeBetween(A:AudioStreamPlayer2D,AVolume:float,B:AudioStreamPlayer2D,BVolume:float):
	var tween = create_tween()
	tween.parallel().tween_property(A,"volume_db",AVolume,2)
	tween.parallel().tween_property(B,"volume_db",BVolume,2)

func playFX(stream:AudioStream,rand:bool):
	if (rand):
		if(RandFXStream.streams_count<RandFXPlayer.max_polyphony):
			RandFXStream.add(-1,stream)
		else:
			RandFXStream.remove_stream(0)
			RandFXStream.add(-1,stream)
		RandFXStream.play()
	else:
		FXPlayer.stream = stream
		FXPlayer.play()
	
	
