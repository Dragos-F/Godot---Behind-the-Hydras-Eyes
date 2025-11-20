extends Node2D

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var onceV1 = true
@export var AlexNotif:AnimatedSprite2D
@export var JenNotif:AnimatedSprite2D
@export var CompNotif:Node2D


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day03"
	Dialogic.VAR.CurrentQuarter = "Quarter3"
	Dialogic.VAR.WatercoolerChar ="Moz"
	
func _process(delta: float) -> void:
	if emails.emailsDone== emails.emailsProgressionQuota && onceV1:
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
		onceV1 = false
func _on_alex_interactable_interacted() -> void:
	AlexNotif.visible = false
	AlexNotif.stop()


func _on_jen_interactable_interacted() -> void:
	JenNotif.visible = false
	JenNotif.stop()


func _on_desk_interactable_interacted() -> void:
	CompNotif.visible = false
