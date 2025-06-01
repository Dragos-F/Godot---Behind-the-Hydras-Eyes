extends CharacterBody2D
class_name Dave
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 275.0
@export var move_time = true
const JUMP_VELOCITY = -400.0
@export var ownSprite : AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var hdirection := Input.get_axis("move_left", "move_right")
	var vdirection := Input.get_axis("move_up", "move_down")
	if move_time:
		
		if hdirection:
			velocity.x = hdirection * SPEED
			if hdirection > 0:
				ownSprite.flip_h = false
			elif hdirection < 0 :
				ownSprite.flip_h = true
				
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if vdirection:
			velocity.y = vdirection * SPEED
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)
		
		if hdirection || vdirection != 0:
			animated_sprite.play("walk")
		
		else:
			animated_sprite.play("idle")
	else:
		velocity.y = 0
		velocity.x = 0

		
	

	move_and_slide()
