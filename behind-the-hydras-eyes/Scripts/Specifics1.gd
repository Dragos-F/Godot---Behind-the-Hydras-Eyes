extends Node2D
@export var alexInteracted:bool = false
@export var AlexNotif:AnimatedSprite2D
@export var jenInteracted:bool = false
@export var JenNotif:AnimatedSprite2D
@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var brain:DayBrain
@export var BossTextAnchor:Node2D


func _ready() -> void:
	var layout = Dialogic.start("Text From Boss")
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Text From Boss.dch",BossTextAnchor)
	
	
func _process(delta: float) -> void:
	if (alexInteracted and jenInteracted and emails.emailsDone==emails.emailsProgressionQuota):
		outsideDoor.readyToLeave = true
		DoorNotif.visible = true

func _on_alex_interactable_interacted() -> void:
	alexInteracted = true
	AlexNotif.visible = false
	AlexNotif.stop()


func _on_jen_interactable_interacted() -> void:
	jenInteracted = true
	JenNotif.visible = false
	JenNotif.stop()
