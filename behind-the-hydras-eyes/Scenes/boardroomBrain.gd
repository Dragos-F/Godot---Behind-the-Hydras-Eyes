extends Node2D
@export var slides:Sprite2D
@export var MozAnchor:Node2D
@export var BossAnchor:Node2D
@export var OluAnchor:Node2D
@export var RichardAnchor:Node2D
@export var DaveAnchor:Node2D
@export var PauseMenu:pauseMenu
@export var once:bool


func _ready() -> void:
	var layout = Dialogic.start("Boardroom")
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Boss.dch",BossAnchor)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Moz.dch",MozAnchor)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Olu.dch",OluAnchor)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Richard.dch", RichardAnchor)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Dave.dch",DaveAnchor)
	

	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.timeline_ended.connect(end_day_boardroom)
	
#func _process(delta: float) -> void:
	#if once && Dialogic.current_timeline !=null:
		#end_day_boardroom()
		#once = false

#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#scroll_along()

func scroll_along():
	var tween = get_tree().create_tween()
	tween.tween_property(slides, "position",Vector2(slides.position.x-1411,slides.position.y),1.5)
	
func _on_dialogic_signal(argument:String):
	print ("inside signal function")
	if argument == "end_boardroom":
		end_day_boardroom()
	if argument == "next_slide":
		print ("inside argument")
		scroll_along()

func _input(event):
	if event.is_action_pressed("menu"):
		if !PauseMenu.visible:
			PauseMenu.openPause()
		elif PauseMenu.visible:
			PauseMenu.closePause()


func end_day_boardroom():
	Achievements.set_achievement("achieve2")
	Fader.FadeUp("Next week")
	await Fader.fade_finished
	Fader.FadeDown("Next week")
	var scene_path = "res://Scenes/Day2.tscn"
	print ("changing scene to "+scene_path)
	get_tree().change_scene_to_file(scene_path)
