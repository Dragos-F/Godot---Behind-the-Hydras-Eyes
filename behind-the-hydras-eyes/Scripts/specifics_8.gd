extends Node

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var bossInteracted:bool = false
@export var BossNotif:AnimatedSprite2D
@export var BossDoor:Interactable
@export var brain:DayBrain
var oncev1 = true
@export var AlexNotif:AnimatedSprite2D
@export var JenNotif:AnimatedSprite2D
@export var CompNotif:Node2D


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day08"
	Dialogic.VAR.CurrentQuarter = "Quarter3"
	Dialogic.VAR.WatercoolerChar ="Alex02"
	
func _process(delta: float) -> void:
	if emails.emailsDone>=emails.emailsProgressionQuota and oncev1:
		BossDoor.readyToLeave = true
		BossNotif.visible = true
		BossNotif.play("default")
		oncev1 = false
		BossDoor.Type = BossDoor.InteractType.BossDoor
	if emails.emailsDone>=emails.emailsProgressionQuota:
		CompNotif.visible = false
	
func _on_boss_door_interacted() -> void:
	BossNotif.visible = false
	bossInteracted = true
	BossNotif.stop()
	
func _on_alex_interactable_interacted() -> void:
	AlexNotif.visible = false
	AlexNotif.stop()


func _on_jen_interactable_interacted() -> void:
	JenNotif.visible = false
	JenNotif.stop()

	
func _on_day_brain_end_of_day() -> void:
	outsideDoor.readyToLeave = true
	DoorNotif.visible = true
	outsideDoor.Type = outsideDoor.InteractType.EntryDoor
