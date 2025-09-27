extends Node2D

@export var sprite:Sprite2D
@export var frown:CompressedTexture2D
@export var contempt:CompressedTexture2D


func _ready() -> void:
	Dialogic.VAR.BossUpset = 0

func _process(delta: float) -> void:
	if Dialogic.VAR.BossUpset == 1:
		sprite.texture = frown
		sprite.scale = Vector2(2,2)
	if Dialogic.VAR.BossUpset >= 2:
		sprite.texture = contempt
		
