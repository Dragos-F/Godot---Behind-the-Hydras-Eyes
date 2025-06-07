class_name Fader extends Node2D

@onready var blinder: Sprite2D = $Sprite2D
@onready var text: Label = $Label
@export var duration:float
@onready var once:bool = true
@onready var tween:Tween
signal fade_finished


#Later to Add text on top of said screen
func FadeDown(target:String): #function that fades down the black screen
		print("FadingDown")
		text.text = target
		if (tween== null):
			tween = get_tree().create_tween()
		else:
			tween.kill()
			tween = get_tree().create_tween()
		tween.tween_property(blinder,"modulate",Color.TRANSPARENT,duration)
		tween.tween_interval(0.5)
		tween.tween_property(text, "modulate",Color.TRANSPARENT,duration)
		await tween.finished
		fade_finished.emit()
		print ("fader finished")
		

func FadeUp(target:String): #function that fades down the black screen
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
		await tween.finished
		fade_finished.emit()
		print ("fader finished")
		
