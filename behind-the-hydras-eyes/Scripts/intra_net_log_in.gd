extends Control


@export var error_message:Label
@export var username:TextEdit
@export var password:TextEdit
@export var timer:Timer
@export var timer2:Timer
@export var error_noise:AudioStream



func _on_log_in_pressed() -> void:	

	if username.text == "admin":
		error_message.text = "GOOD TRY, BUT NO LUCK"
		error_message.visible = true
	elif username.text == "d.spritely" or username.text == "dave.spritely":
		error_message.text = "PASSWORD EXPIRED. CONTACT SYSTEM ADMIN"
		error_message.visible = true
	else:
		error_message.text = "INCORRECT USERNAME / PASSWORD"
		error_message.visible = true

	timer.start()
	timer2.start()
	AudioBrain.playFX(error_noise,false)
	username.text = ""
	password.text = ""


func _on_timer_timeout() -> void:
	if error_message.visible:
		error_message.visible = false
	else:
		error_message.visible = true


func _on_timer_2_timeout() -> void:
	timer.stop()
	error_message.visible = false
