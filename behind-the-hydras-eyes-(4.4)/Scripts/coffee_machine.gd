extends Sprite2D


@export var anim:AnimatedSprite2D


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "coffee":
		anim.visible = true
		anim.play("Pour")
		await anim.animation_finished
		anim.visible = false
