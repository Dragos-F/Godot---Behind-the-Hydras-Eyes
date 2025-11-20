extends Node

@export var alexInteracted:bool = false
@export var AlexNotif:AnimatedSprite2D
@export var jenInteracted:bool = false
@export var JenNotif:AnimatedSprite2D
@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var bossInteracted:bool = false
@export var BossNotif:AnimatedSprite2D
@export var BossDoor:Interactable
@export var brain:DayBrain
@export var specific_emails:Array[EmailBrain]
var oncev1 = true
@export var CompNotif:Node2D


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day05"
	Dialogic.VAR.CurrentQuarter = "Quarter2"
	Dialogic.VAR.WatercoolerChar ="Olu"
	Dialogic.VAR.AlexNayeli = false
	if PermanentGlobal.LocationChoice !=null:
		specific_emails[PermanentGlobal.LocationChoice-1].visible = true
	else:
		specific_emails[0].visible = true
	
func _process(delta: float) -> void:
	if emails.emailsDone==emails.emailsProgressionQuota and oncev1:
		BossDoor.readyToLeave = true
		BossNotif.visible = true
		BossNotif.play("default")
		oncev1 = false
		BossDoor.Type = BossDoor.InteractType.BossDoor
	if emails.emailsDone==emails.emailsProgressionQuota:
		Dialogic.VAR.AlexNayeli = true

func _on_alex_interactable_interacted() -> void:
	alexInteracted = true
	AlexNotif.visible = false
	AlexNotif.stop()


func _on_jen_interactable_interacted() -> void:
	jenInteracted = true
	JenNotif.visible = false
	JenNotif.stop()
	
func _on_desk_interactable_interacted() -> void:
	CompNotif.visible = false
	
func _on_boss_door_interacted() -> void:
	BossNotif.visible = false
	bossInteracted = true
	BossNotif.stop()
	
func _on_day_brain_end_of_day() -> void:
	outsideDoor.readyToLeave = true
	DoorNotif.visible = true
	outsideDoor.Type = outsideDoor.InteractType.EntryDoor
	
