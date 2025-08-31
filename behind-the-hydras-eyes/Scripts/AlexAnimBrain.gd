extends Sprite2D

@export var MainSprite: Sprite2D
@export var SpriteAnim: AnimatedSprite2D
@export var Chair: Sprite2D
@export var CoffeeMug: Sprite2D
@export var Mouse: Sprite2D
@export var timer: Timer
@export var minTime: float
@export var maxTime: float
@export var regularAlex: CompressedTexture2D


func _ready() -> void:
	timer.wait_time = randf_range(minTime, maxTime)
	timer.start()

func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(minTime, maxTime)
	timer.start()
	TurnSpritesOff()
	
	if (randi_range(0,1)==0):
		SpriteAnim.play("drink_tea")
	else:
		SpriteAnim.play("mouse_wiggle")
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	ResetSprites()


func TurnSpritesOff() -> void:
	MainSprite.texture = null
	Chair.visible = false
	CoffeeMug.visible = false
	Mouse.visible = false
	SpriteAnim.visible = true

	
func ResetSprites():
	MainSprite.texture = regularAlex
	Chair.visible = true
	CoffeeMug.visible = true
	SpriteAnim.visible = false
	Mouse.visible = true


func _on_area_2d_body_entered(_body: Node2D) -> void:
	SpriteAnim.visible = false
	timer.stop()
	


func _on_area_2d_body_exited(_body: Node2D) -> void:
	SpriteAnim.visible = true
	timer.start()
