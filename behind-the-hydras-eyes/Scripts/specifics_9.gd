extends Node2D

@export var emails:Computer
@export var outsideDoor:Interactable
@export var DoorNotif:AnimatedSprite2D
@export var bossInteracted:bool = false
@export var BossNotif:AnimatedSprite2D
@export var BossDoor:Interactable
@export var brain:DayBrain
@export var email_reminder:Control
@export var computer_target:Node2D
@export var timer:Timer
@export var email_notification:Node2D
var oncev1 = true


func _ready() -> void:
	Dialogic.VAR.CurrentDay = "Day09"
	Dialogic.VAR.CurrentQuarter = "Quarter4"
	Dialogic.VAR.WatercoolerChar ="No-one"
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _process(delta: float) -> void:
	pass
	
func _on_boss_door_interacted() -> void:
	BossNotif.visible = false
	bossInteracted = true
	BossNotif.stop()
	
func _on_day_brain_end_of_day() -> void:
	outsideDoor.readyToLeave = true
	DoorNotif.visible = true
	outsideDoor.Type = outsideDoor.InteractType.EntryDoor
	
func _on_dialogic_signal(argument:String):
		if argument == "reminder":
			email_reminder.visible = true
			email_notification.visible = true
			BossDoor.readyToLeave = true
			BossNotif.visible = true
			BossNotif.play("default")
			oncev1 = false
			BossDoor.Type = BossDoor.InteractType.BossDoor


func _on_day_brain_introspection() -> void:
	timer.start()
	

func _on_timer_timeout() -> void:
	Dialogic.Styles.load_style("Bubble Style Test")
	var layout = Dialogic.start("Introspection")
	layout.register_character ("res://Dialogue stuffs/Dialogic/Characters/Office/Computer.dch",computer_target)
