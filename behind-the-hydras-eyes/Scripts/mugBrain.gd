extends Node2D

class_name mugBrain
@export var fillAnimation:AnimatedSprite2D
@export var full:bool = false
@export var hasBag:bool = false
@export var teaBrown:Color
@export var milkyTea:Color
@export var newFill:bool = false #needed so that filling doesn't trigger colour change
@export var bagSprite:Sprite2D
@export var sugar: int = 0
@export var cubes:Array[Node2D]

var darken:Tween
var lighten:Tween

func _process(_delta: float) -> void:
	if fillAnimation.frame_progress == 1:
		full = true
	if hasBag && !bagSprite.visible:
		bagSprite.visible = true
	if hasBag &&full:
		bagSprite.visible = false
	if sugar > 0 && sugar < 4 && !full:
		for i in sugar:
			cubes[i-1].visible = true
	if sugar > 0 && full:
		for i in cubes.size():
			cubes[i].visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !full:
		if area.get_parent().name == "Nut" or area.get_parent().name == "Cow":
			fillAnimation.play("milk")
		elif area.get_parent().name =="Kettle":
			if hasBag:
				fillAnimation.play("tea")
			elif !hasBag:
				fillAnimation.play("water")
			
		elif area.get_parent().name == "TeaBag":
			area.get_parent().queue_free()
			hasBag = true
		elif area.get_parent().name == "Cube":
			area.get_parent().queue_free()
			sugar +=1
	elif full and newFill:
		if area.get_parent().name == "Nut" or area.get_parent().name == "Cow" and hasBag:
			teaColour(2)
		#if area.get_parent().name == "Kettle"and hasBag:
			#teaColour(1)
		if area.get_parent().name == "TeaBag":
			area.get_parent().queue_free()
			fillAnimation.play_backwards("tea")
			fillAnimation.pause()
			teaColour(1)
			hasBag = true
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name != "TeaBag":
		fillAnimation.pause()
		teaColour(0)
		if full:
			newFill = true
	
	
#0 - stop tweens
#2 make milky
#1 make darker
func teaColour(i:int): 
	print("TeaColourCalled")
	if !darken:
		darken = create_tween()
	if !lighten:
		lighten = create_tween()
	darken.tween_property(fillAnimation,"modulate",teaBrown,3)
	darken.stop()
	lighten.tween_property(fillAnimation,"modulate",milkyTea,3)
	lighten.stop()
	if i == 1:
		print("darkening")
		darken.play()
	if i == 2:
		print ("lightening")
		lighten.play()
	if i == 0:
		print("paused")
		lighten.stop()
		darken.stop()
