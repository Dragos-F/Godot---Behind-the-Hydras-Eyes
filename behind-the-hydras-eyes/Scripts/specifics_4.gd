extends Node2D
@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var onceV1 = true
@export var AlexNotif:AnimatedSprite2D
@export var JenNotif:AnimatedSprite2D
@export var CompNotif:Node2D

func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day04"
	Dialogic.VAR.WatercoolerChar ="Richard"
	Dialogic.VAR.Day4AlexEmails = false
	
func _process(delta: float) -> void:
	if emails.emailsDone == emails.emailsProgressionQuota && onceV1:
		Dialogic.VAR.Day4AlexEmails = true
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
		onceV1 = false


func _on_save_button_pressed() -> void: # approve budget
	Dialogic.VAR.BudgetApproved = true

func _on_alex_interactable_interacted() -> void:
	AlexNotif.visible = false
	AlexNotif.stop()


func _on_jen_interactable_interacted() -> void:
	JenNotif.visible = false
	JenNotif.stop()


func _on_desk_interactable_interacted() -> void:
	CompNotif.visible = false
