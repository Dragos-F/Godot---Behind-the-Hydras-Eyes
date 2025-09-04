extends Node

@onready var LocationChoice:float
@onready var Savings:float
@onready var Lifestyle:float
@onready var Plant:bool = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(reset_focus)


func _input(event: InputEvent) -> void:
	if Dialogic.current_timeline!= null:
		if event.is_action("ui_up") or event.is_action("ui_down"):
			var choice:DialogicSubsystem = Dialogic.get_subsystem("Choices")
			if choice.autofocus_first_choice == false:
				choice.autofocus_first_choice = true
				Dialogic.Save.save()
				Dialogic.Save.load()
				print ("Highlighted first choice")

func reset_focus():
	var choice:DialogicSubsystem = Dialogic.get_subsystem("Choices")
	choice.autofocus_first_choice = false
