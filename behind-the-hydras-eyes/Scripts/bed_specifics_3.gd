extends Node
@export var computer_container:TabContainer

func _ready() -> void:
	Dialogic.VAR.CurrentQuarter = "Quarter3"
	computer_container.set_tab_hidden(1,true)
