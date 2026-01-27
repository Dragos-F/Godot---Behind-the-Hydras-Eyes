extends Node

@onready var LocationChoice:float
@onready var Savings:float = 2400
@onready var Lifestyle:String
@onready var Plant:bool = false
@onready var email_choices = {}
@onready var deleted:int
@onready var watercoolers:int
@export var click_pause:bool = true
var oncev1:bool = true
var oncev2:bool = true
#var arrow = load("res://Visual Assets/New Assets/Menus/Computer UIs/Mouse normal.png")
var arrow = load("res://Visual Assets/New Assets/Menus/Computer UIs/Mouse branded 64.png")
var finger = load("res://Visual Assets/New Assets/Menus/Computer UIs/Mouse finger.png")
func _ready() -> void:
	Dialogic.timeline_ended.connect(reset_focus)
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(finger,Input.CURSOR_POINTING_HAND)
	

#func _unhandled_key_input(event: InputEvent) -> void:
	#if event.is_action_pressed("dialogic_default_action")&& click_pause && Dialogic.current_timeline != null:
		#print("start disabling input")
		#click_pause = false
		#Dialogic.process_mode = Node.PROCESS_MODE_DISABLED
		#print("dialogic disabled")
		#await get_tree().create_timer(0.2).timeout
		#Dialogic.process_mode = Node.PROCESS_MODE_INHERIT
		#print ("dialogic reenabled")
		#click_pause = true
	#if event.is_action_pressed("dialogic_default_action")&& click_pause && Dialogic.current_timeline != null:
		#click_pause = false
		#Dialogic.Inputs.block_input(3)
		#await Dialogic.Inputs.input_block_timer.timeout
		#click_pause = true

func _input(event: InputEvent) -> void:		
		
	if Dialogic.current_timeline!= null:
		if event.is_action("ui_up") or event.is_action("ui_down"):
			var choice:DialogicSubsystem = Dialogic.get_subsystem("Choices")
			if choice.autofocus_first_choice == false:
				choice.autofocus_first_choice = true
				Dialogic.Save.save()
				Dialogic.Save.load()
				print ("Highlighted first choice")

		


func _process(delta: float) -> void:
	if deleted >=32 && oncev1:
		Achievements.set_achievement("achieve4")
		oncev1 = false
	if watercoolers >= 9 &&oncev2:
		Achievements.set_achievement("achieve5")
		oncev2 = false
	#print (watercoolers)
	#print (Dialogic.Inputs.input_block_timer.time_left)

func reset_focus():
	var choice:DialogicSubsystem = Dialogic.get_subsystem("Choices")
	choice.autofocus_first_choice = false

func new_choice(emailTitle:String, choice:int) -> void:
	email_choices[emailTitle] = choice
	
func reset_choices():
	LocationChoice = 0
	Savings = 2400
	Lifestyle = "Moderate"
	Plant = false
	deleted = 0
	watercoolers = 0 
	oncev1 = true
	oncev2 = true
	email_choices.clear()
	
	
