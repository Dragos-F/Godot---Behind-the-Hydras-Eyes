extends Node2D
@export var slides:Sprite2D
@export var MozAnchor:Node2D
@export var BossAnchor:Node2D

func _ready() -> void:
	var layout = Dialogic.start("Boardroom")
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Office/Boss.dch",BossAnchor)
	layout.register_character("res://Dialogue stuffs/Dialogic/Characters/Moz.dch",MozAnchor)
	
	Dialogic.signal_event.connect(_on_dialogic_signal)

#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#scroll_along()

func scroll_along():
	var tween = get_tree().create_tween()
	tween.tween_property(slides, "position",Vector2(slides.position.x-1411,slides.position.y),1.5)
	
func _on_dialogic_signal(argument:String):
	print ("inside signal function")
	if argument == "next_slide":
		print ("inside argument")
		scroll_along()
