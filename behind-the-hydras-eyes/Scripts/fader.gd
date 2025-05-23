class_name Fader extends Node2D

@onready var blinder: Sprite2D = $Sprite2D
@onready var text: Label = $Label
@export var duration:float
@onready var once:bool = true
@onready var tween:Tween


#Function to fade to a black screen,
#Later to Add text on top of said screen
func FadeDown():
		print("FadingDown")
		if (tween== null):
			tween = get_tree().create_tween()
		else:
			tween.kill()
			tween = get_tree().create_tween()
		tween.tween_property(blinder,"modulate",Color.TRANSPARENT,duration)
		tween.tween_interval(0.5)
		tween.tween_property(text, "modulate",Color.TRANSPARENT,duration)

func FadeUp(target:String):
		print("FadingUp")
		text.text = target
		if (tween== null):
			tween = get_tree().create_tween()
		else:
			tween.kill()
			tween = get_tree().create_tween()
		tween.tween_property(blinder,"modulate",Color.BLACK,duration)
		tween.tween_interval(0.5)
		tween.tween_property(text, "modulate",Color.WHITE,duration)
		
