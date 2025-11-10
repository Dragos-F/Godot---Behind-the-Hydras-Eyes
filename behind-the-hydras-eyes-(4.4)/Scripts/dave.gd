extends CharacterBody2D
class_name Dave
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 275.0
@export var move_time = true
const JUMP_VELOCITY = -400.0
@export var ownSprite : AnimatedSprite2D
@export var walking_audio:AudioStream
@export var walking:bool = false
@export var oncev1:bool = true

func _ready() -> void:
	Dialogic.timeline_started.connect(_stopDave)
	Dialogic.timeline_ended.connect(_restartDave)
	self.z_index = 0
	
func _stopDave():
	move_time = false
	if (animated_sprite.get_animation() =="walk"):
		animated_sprite.play("idle")
func _restartDave():
	move_time = true
	

func _physics_process(_delta: float) -> void:
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
			oncev1 = true
			animated_sprite.play("walk")
			if (!walking):
				#AudioBrain.playFX(walking_audio,false)
				walking = true
		
		else:
			if (animated_sprite.get_animation() =="walk"):
				animated_sprite.play("idle")
			
			walking = false
			
			
	else:
		velocity.y = 0
		velocity.x = 0

		
	

	move_and_slide()
