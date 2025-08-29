extends Node
class_name DayBrain

@onready var screen_ui: Control
@onready var dave:Dave = %Dave
@onready var computer_screen: Node2D = $"../ComputerScreen"
@export var BossScreen:Node2D
@export var BossDialogue:Node2D
@export var DaveAnchor:Node2D
@export var BossAnchor:Node2D
@export var TextAnchor:Node2D
@export var Camera:Camera2D
@export var camera_zoom:Vector2
@export var camera_target:Vector2
@export var standing_Alex:Node2D
@export var AlexAnchor:Node2D
@export var JenAnchor:Node2D
@export var TeaMinigame:Node2D
signal endOfDay() # emitted by the dayBrain to let the specifics know when to end. 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_ui = get_tree().current_scene.get_node("ScreenUI")
	Dialogic.signal_event.connect(_on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shut_down_pressed() -> void:
	Fader.FadeUp("")
	await Fader.fade_finished
	print ("past await")
	screen_ui.visible = false
	computer_screen.visible = false
	Fader.FadeDown("")
	dave.move_time = true
	await Fader.fade_finished
	
	
func enter_screen():
	dave.move_time = false
	Fader.FadeUp("")
	await Fader.fade_finished
	print ("past await")
	screen_ui.visible = true
	computer_screen.visible = true
	Fader.FadeDown("")
	await Fader.fade_finished

func enter_boss():
	dave.move_time = false
	Fader.FadeUp("P. Moore's Office")
	await Fader.fade_finished
	print ("past await")
	BossScreen.visible = true
	Fader.FadeDown("P. Moore's Office")
	await Fader.fade_finished
	Dialogic.Styles.load_style("BottomDialogue")
	Dialogic.start("Boss")
	await Dialogic.timeline_ended
	print ("AWAIT COMPLETE, LEAVING BOSS")
	leave_boss()

func leave_boss():
	dave.move_time = false
	Fader.FadeUp("The Main Office")
	await Fader.fade_finished
	print ("past await")
	BossScreen.visible = false
	Fader.FadeDown("The Main Office")
	dave.move_time = true
	endOfDay.emit()

func tea_minigame():
	Fader.FadeUp("Kitchen Counter")
	await Fader.fade_finished
	TeaMinigame.visible = true
	Fader.FadeDown("Kitchen Counter")
	
#func _on_desk_interactable_interacted() -> void:
	#enter_screen()
	#print ("entering screen")
	

func run_dialogue(nodeTitle:String,target:Node2D): #This starts dialogic from whatever calls it, registering characters 
	camera_target = target.global_position # and bubble target anchors. Couldn't think of a smarter way, so now we have this
	var tween = get_tree().create_tween()
	tween.tween_property(Camera,"zoom",camera_zoom,2)
	tween.set_parallel()
	tween.tween_property(Camera,"position",camera_target,2)
	tween.tween_interval(0.1)
	Dialogic.Styles.load_style("Bubble Style Test")
	var layout = Dialogic.start(nodeTitle)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Dave.dch",DaveAnchor)
	if (nodeTitle == "Alex"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Alex.dch",target)
	if (nodeTitle == "Jen"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Jen.dch",target)
	if (nodeTitle == "Boss"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Boss.dch",target)
	if (nodeTitle == "Clipboard"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Clipboard.dch",target)
	if (nodeTitle == "Coffee"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/CoffeeMachine.dch",target)
	if (nodeTitle ==  "Kettle"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Kettle.dch",target)
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Alex.dch",AlexAnchor)
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Jen.dch",JenAnchor)
	if (nodeTitle == "Text From Boss"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Text from Boss.dch",target)
	if (nodeTitle == "WaterCooler"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/WaterCooler.dch",target)
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Alex.dch",standing_Alex)
	if (nodeTitle == "Corkboard"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Corkboard.dch",target)
	if (nodeTitle == "Posters"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Posters.dch",target)
	if (nodeTitle == "Bed"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Bed.dch",target)
	if (nodeTitle == "Balcony Door"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Balcony Door.dch",target)
	if (nodeTitle == "Bathroom Door"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Bathroom Door.dch",target)
	if (nodeTitle == "Dirty Dishes"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Dirty Dishes.dch",target)
	if (nodeTitle == "Front Door"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Front Door.dch",target)
	if (nodeTitle == "Bookshelf"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Bedroom/Bookshelf.dch",target)
	
	if (nodeTitle == "BossDoor"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Alex.dch",target)
	if (nodeTitle == "FilingCabinet"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/FilingCabinet.dch",target)
	if (nodeTitle == "BossDoor"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/BossDoor.dch",target)
	
	
	await Dialogic.timeline_ended
	print ("timeline ended")
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(Camera,"zoom",Vector2.ONE,1)
	tween.set_parallel()
	tween.tween_property(Camera,"position",Vector2.ZERO,1)

func end_day(nextLocation:String,scene_path:String):
	Fader.FadeUp(nextLocation)
	await Fader.fade_finished
	Fader.FadeDown(nextLocation)
	print ("changing scene to "+scene_path)
	get_tree().change_scene_to_file(scene_path)

func _on_dialogic_signal(argument:String):
	if argument == "bed_sleep":
		end_day("Q2, 202X","res://Scenes/EndOfDemo.tscn")
	if argument == "watercooler_Alex":
		standing_Alex.visible = true
	if argument == "no_watercooler_Alex":
		standing_Alex.visible = false
	if argument == "tea_minigame":
		tea_minigame()
		
		
