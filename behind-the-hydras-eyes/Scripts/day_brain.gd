extends Node
class_name DayBrain
@onready var fader: Fader = $"../Fader"
@export var dialog: DialogueRunner
@onready var screen_ui: Control
@onready var dave:Dave = %Dave
@onready var computer_screen: Node2D = $"../ComputerScreen"

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
	await fader.fade_finished
	dave.move_time = true
	
func enter_screen():
	dave.move_time = false
	fader.FadeUp("")
	await fader.fade_finished
	print ("past await")
	screen_ui.visible = true
	computer_screen.visible = true
	fader.FadeDown("")
	await fader.fade_finished

func _on_desk_interactable_interacted() -> void:
	enter_screen()
	print ("entering screen")
	
	
func run_dialogue(nodeTitle:String):
	dialog.StartDialogue(nodeTitle)
	print ("brain told runner to start it")

func end_day(nextLocation:String):
	fader.FadeUp(nextLocation)
	await fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/Day2.tscn")
