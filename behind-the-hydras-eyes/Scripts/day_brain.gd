extends Node
class_name DayBrain

@onready var screen_ui: Control
@onready var dave:Dave = %Dave
@onready var computer_screen: Node2D = $"../ComputerScreen"
@export var BossScreen:Node2D
@export var BossDialogue:Node2D
@export var DaveAnchor:Node2D
@export var TextAnchor:Node2D
@export var Camera:Camera2D
@export var camera_zoom:Vector2
@export var camera_target:Vector2


signal endOfDay() # emitted by the dayBrain to let the specifics know when to end. 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_ui = get_tree().current_scene.get_node("ScreenUI")


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
	run_dialogue("Boss", BossDialogue)
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
	await Fader.fade_finished


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
	if (nodeTitle == "CoffeeMachine"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/CoffeeMachine.dch",target)
	if (nodeTitle ==  "Kettle"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Kettle.dch",target)
	if (nodeTitle == "Text From Boss"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Text from Boss.dch",target)
	if (nodeTitle == "WaterCooler"):
		layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/WaterCooler.dch",target)
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
	
	await Dialogic.timeline_ended
	print ("timeline ended")
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(Camera,"zoom",Vector2.ONE,1)
	tween.set_parallel()
	tween.tween_property(Camera,"position",Vector2.ZERO,1)

func end_day(nextLocation:String):
	Fader.FadeUp(nextLocation)
	await Fader.fade_finished
	Fader.FadeDown(nextLocation)
	get_tree().change_scene_to_file("res://Scenes/Day2.tscn")
