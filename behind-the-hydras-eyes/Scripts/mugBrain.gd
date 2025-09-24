extends Node2D

class_name mugBrain
@export var fillAnimation:AnimatedSprite2D
@export var full:bool = false
@export var hasBag:bool = false
@export var teaBrown:Color # actually just plain white
@export var milkyTea:Color # overbright white that compensates from tea brown
@export var actualTea:Color # the only one meant to be tea coloured
@export var preMilkInMug:Color
@export var topUpMilk:Color
@export var newFill:bool = false #needed so that filling doesn't trigger colour change
@export var bagSprite:Sprite2D
@export var sugar: int = 0
@export var cubes:Array[Node2D]
@export var oncev1:bool = true
@export var removable:bool = false
@export var removed:bool = false
@export var regularBag = CompressedTexture2D
@export var selectedBag = CompressedTexture2D
@onready var minigame:minigame_brain = get_node("/root/Main/TeaMinigame")
@export var teaPour:bool = false
@export var milkPour:bool = false
@export var milkFrames:int #counting how many frames of milk have been poured
@export var teaFrames:int
@export var oncev2:bool = true


var darken:Tween
var lighten:Tween
var even_darker:Tween

func _ready() -> void:
	if minigame == null:
		minigame = get_node("/root/TeaMinigame")

func _process(_delta: float) -> void:
	if fillAnimation.frame_progress == 1:
		full = true
	if hasBag && !bagSprite.visible && !removed:
		bagSprite.visible = true
	if hasBag &&full:
		#bagSprite.visible = false
		removable = true
	if sugar > 0 && sugar < 4 && !full:
		for i in sugar:
			cubes[i-1].visible = true
	if sugar > 0 && full:
		for i in cubes.size():
			cubes[i].visible = false
	if full && hasBag && oncev1:
		#teaColour(3)
		oncev1 = false


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
			minigame.holding = false
		elif area.get_parent().name == "Cube":
			area.get_parent().queue_free()
			minigame.holding = false
			sugar +=1
	elif full and newFill:
		if area.get_parent().name == "Nut" or area.get_parent().name == "Cow" and hasBag:
			teaColour(2)
		#if area.get_parent().name == "Kettle"and hasBag:
			#teaColour(1)
		if area.get_parent().name == "TeaBag":
			area.get_parent().queue_free()
			minigame.holding = false
			fillAnimation.play_backwards("tea")
			fillAnimation.pause()
			#teaColour(1)
			hasBag = true
		elif area.get_parent().name == "Cube":
			area.get_parent().queue_free()
			sugar +=1
			minigame.holding = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name != "TeaBag":
		fillAnimation.pause()
		teaColour(0)
		#oncev1 = true
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
	if !even_darker:
		even_darker = create_tween()
	even_darker.tween_property(fillAnimation,"modulate",actualTea,3)
	even_darker.stop()
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
	if i == 3:
		print ("going to even darker")
		even_darker.play()
		await even_darker.finished
		fillAnimation.play_backwards("tea")
		fillAnimation.pause()


func _on_area_2d_mouse_entered() -> void:
	if removable:
		bagSprite.texture = selectedBag


func _on_area_2d_mouse_exited() -> void:
	bagSprite.texture = regularBag
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed() \
	and removable:
		bagSprite.visible = false
		removed = true
		
func reset():
	fillAnimation.stop()
	fillAnimation.frame_progress = 0
	full = false
	hasBag = false
	bagSprite.visible = false
	sugar = 0
	newFill = false
	removable = false
	removed = false
	for i in cubes:
		i.visible = false
		print ("Mug Reset Indeed")


func _on_fill_animation_changed() -> void:
	if fillAnimation.animation == "tea" && milkPour && !full && oncev2:
		fillAnimation.modulate = preMilkInMug
		fillAnimation.frame = milkFrames
		oncev2 = false
	if fillAnimation.animation == "milk" && teaPour && !full && oncev2:
		fillAnimation.modulate = topUpMilk
		fillAnimation.frame = teaFrames
		oncev2 = false



func _on_fill_frame_changed() -> void:
	if fillAnimation.animation == "milk" && fillAnimation.frame>1:
		milkPour = true
		milkFrames = fillAnimation.frame
	if fillAnimation.animation == "tea" && fillAnimation.frame>1:
		teaPour = true
		teaFrames = fillAnimation.frame
		
