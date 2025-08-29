extends Sprite2D

@export var MainSprite: Sprite2D
@export var SpriteAnim: AnimatedSprite2D
@export var regularJen: CompressedTexture2D
@export var timer: Timer
@export var minTime: float
@export var maxTime: float

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
		SpriteAnim.play("phone_check")
	
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	ResetSprites()


func TurnSpritesOff() -> void:
	MainSprite.texture = null
	SpriteAnim.visible = true

	
func ResetSprites():
	MainSprite.texture = regularJen
	SpriteAnim.visible = false
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	SpriteAnim.visible = false
	


func _on_area_2d_body_exited(_body: Node2D) -> void:
	SpriteAnim.visible = true
