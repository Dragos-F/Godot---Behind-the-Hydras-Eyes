extends Node2D
class_name pauseMenu
@export var folderAnim:AnimatedSprite2D
@export var saveMessage:Control
@export var allControl:Control
@export var randText:RichTextLabel
@export var possibleTexts:Array[String]
@export var topLimit:float
@export var botLimit:float
@export var leftLimit:float
@export var rightLimit:float
@export var angleLimit:float
@export var back_slide:HSlider
@export var sfx_slide:HSlider
@export var ui_slide:HSlider

func _ready() -> void:
	back_slide.value = AudioBrain.BackPlayer.volume_db
	sfx_slide.value = AudioBrain.FXPlayer.volume_db
	ui_slide.value = AudioBrain.UIsfxPlayer.volume_db
	

func _on_background_value_changed(value: float) -> void:
	AudioBrain.BackPlayer.volume_db = value
	
func _on_sfx_value_changed(value: float) -> void:
	AudioBrain.FXPlayer.volume_db = value
	AudioBrain.RandFXPlayer.volume_db = value
	
func _on_ui_value_changed(value: float) -> void:
	AudioBrain.UIsfxPlayer.volume_db = value
	
func _on_restart_pressed() -> void:
	#Fader.FadeUp("")
	#await Fader.fade_finished
	#get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	#Fader.FadeDown("")
	saveMessage.visible = true

func _on_credits_pressed() -> void:
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/EndOfDemo.tscn")
	Fader.FadeDown("")

func openPause():
	self.visible = true
	folderAnim.play("open")
	await folderAnim.animation_finished
	randomScribble()
	randText.visible = true
	allControl.visible = true
func closePause():
	allControl.visible = false
	randText.visible = false
	saveMessage.visible = false
	folderAnim.play_backwards("open")
	await folderAnim.animation_finished
	self.visible = false

func randomScribble():
	possibleTexts.shuffle()
	randText.text = possibleTexts[0]
	randText.position = Vector2(randf_range(leftLimit,rightLimit),randf_range(topLimit,botLimit))
	randText.rotation_degrees = randf_range(-angleLimit,angleLimit)


func _on_message_okay_pressed() -> void:
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	Fader.FadeDown("")
