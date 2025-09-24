extends Control


@export var error_message:Label
@export var username:TextEdit
@export var password:TextEdit
@export var timer:Timer
@export var error_noise:AudioStream



func _on_log_in_pressed() -> void:
	username.text = ""
	password.text = ""
	timer.start()
	error_message.visible = true
	AudioBrain.playFX(error_noise,false)

func _on_timer_timeout() -> void:
	if error_message.visible:
		error_message.visible = false
	else:
		error_message.visible = true
	
