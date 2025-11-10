extends Node
@export var alexInteracted:bool = false
@export var AlexNotif:AnimatedSprite2D
@export var jenInteracted:bool = false
@export var JenNotif:AnimatedSprite2D
@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var brain:DayBrain
@export var BossTextAnchor:Node2D
@export var BossDoor:Interactable
@export var TeaNotif:Node2D
@export var ClipNotif:Node2D
@export var CompNotif:Node2D
var onceV1:bool = true
var onceV2:bool = true
var onceV3:bool = true

func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day01"
	Dialogic.VAR.WatercoolerChar = "Alex01"
	
	
	
func _process(_delta: float) -> void:
	if (alexInteracted and jenInteracted and emails.emailsDone==emails.emailsProgressionQuota):
		outsideDoor.readyToLeave = true
		outsideDoor.Type = outsideDoor.InteractType.EntryDoor
		DoorNotif.visible = true
	if Dialogic.VAR.teaNotif == true && !TeaNotif.visible && onceV1:
		TeaNotif.visible = true
		onceV1 = false
		TeaNotif.play()
	if Dialogic.VAR.clipNotif == true && !ClipNotif.visible && onceV2:
		ClipNotif.visible = true
		onceV2 = false
		ClipNotif.play()
	if Dialogic.VAR.AlexReturn || Dialogic.VAR.JenReturn && !CompNotif.visible:
		if onceV3:
			CompNotif.visible = true
			onceV3 = false

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


func _on_interactable_element_interacted() -> void:
	TeaNotif.visible = false
func  _on_clipboard_interacted() ->void:
	ClipNotif.visible = false
