extends Node
class_name DayBrain
@onready var fader: Fader = $"../Fader"
@export var dialog: DialogueRunner
@onready var screen_ui: Control = %ScreenUI
@onready var dave:Dave = %Dave
@onready var computer_screen: Node2D = $"../ComputerScreen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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


func _on_interactable_element_interacted() -> void:
	enter_screen()
	
func run_dialogue(nodeTitle:String):
	dialog.StartDialogue(nodeTitle)
	print ("brain told runner to start it")
