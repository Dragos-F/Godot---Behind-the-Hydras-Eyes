extends Node2D

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var onceV1 = true


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day07"
	Dialogic.VAR.WatercoolerChar ="Jen02"
	Dialogic.VAR.JanineReturn = false
	
func _process(delta: float) -> void:
	if emails.emailsDone == emails.emailsProgressionQuota && onceV1:
		Dialogic.VAR.Day4AlexEmails = true
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
		onceV1 = false
