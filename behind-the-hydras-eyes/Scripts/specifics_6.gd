extends Node2D

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var onceV1 = true
@export var onceV2 = true
@export var onceV3 = true
@export var AlexNotif:Node2D
@export var JenNotif:Node2D


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day06"
	Dialogic.VAR.WatercoolerChar ="Janine"
	Dialogic.VAR.JanineReturn = false
	Dialogic.VAR.AlexNayali = false
	
func _process(delta: float) -> void:
	if emails.emailsDone == emails.emailsProgressionQuota && onceV1:
		Dialogic.VAR.Day4AlexEmails = true
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
		onceV1 = false
		Dialogic.VAR.AlexNayeli = true
	if emails.emailsDone == emails.emailsProgressionQuota && onceV2:
		AlexNotif.visible = true
		onceV2 = false
	if emails.emailsDone == emails.emailsProgressionQuota && onceV3:
		JenNotif.visible = true
		onceV3 = false


func _on_jen_interactable_interacted() -> void:
	JenNotif.visible = false

func _on_alex_interactable_interacted() -> void:
	AlexNotif.visible = false
