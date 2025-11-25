extends Node2D

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var StickyNotif: Node2D
@export var brain: DayBrain
@export var onceV1 = true
@export var CompNotif:Node2D

func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day07"
	Dialogic.VAR.WatercoolerChar ="Janine"
	Dialogic.VAR.JanineReturn = false
	
func _process(delta: float) -> void:
	if emails.emailsDone >= emails.emailsProgressionQuota && onceV1:
		Dialogic.VAR.Day4AlexEmails = true
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
		onceV1 = false
	if emails.emailsDone>=emails.emailsProgressionQuota:
		CompNotif.visible = false


func _on_interactable_element_interacted() -> void:
	StickyNotif.visible = false
	


func _on_timer_timeout() -> void:
	brain.run_dialogue("EmptyOffice",outsideDoor)
