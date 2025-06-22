extends Node
class_name DayBrain
@onready var fader: Fader = $"../Fader"
@onready var screen_ui: Control
@onready var dave:Dave = %Dave
@onready var computer_screen: Node2D = $"../ComputerScreen"
@export var BossScreen:Node2D

signal endOfDay() # emitted by the dayBrain to let the specifics know when to end. 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_ui = get_tree().current_scene.get_node("ScreenUI")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shut_down_pressed() -> void:
	fader.FadeUp("")
	await fader.fade_finished
	print ("past await")
	screen_ui.visible = false
	computer_screen.visible = false
	fader.FadeDown("")
	dave.move_time = true
	await fader.fade_finished
	
	
func enter_screen():
	dave.move_time = false
	fader.FadeUp("")
	await fader.fade_finished
	print ("past await")
	screen_ui.visible = true
	computer_screen.visible = true
	fader.FadeDown("")
	await fader.fade_finished

func enter_boss():
	dave.move_time = false
	fader.FadeUp("P. Moore's Office")
	await fader.fade_finished
	print ("past await")
	BossScreen.visible = true
	fader.FadeDown("P. Moore's Office")
	await fader.fade_finished
	run_dialogue("Boss")
	await Dialogic.timeline_ended
	print ("AWAIT COMPLETE, LEAVING BOSS")
	leave_boss()

func leave_boss():
	dave.move_time = false
	fader.FadeUp("The Main Office")
	await fader.fade_finished
	print ("past await")
	BossScreen.visible = false
	fader.FadeDown("The Main Office")
	dave.move_time = true
	await fader.fade_finished


func _on_desk_interactable_interacted() -> void:
	enter_screen()
	print ("entering screen")
	
	
func run_dialogue(nodeTitle:String):
	Dialogic.start(nodeTitle)
	print ("brain told runner to start it")

func end_day(nextLocation:String):
	fader.FadeUp(nextLocation)
	await fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/Day2.tscn")
