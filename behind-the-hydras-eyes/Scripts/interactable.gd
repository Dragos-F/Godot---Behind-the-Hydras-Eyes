extends Node2D
class_name Interactable
@export var parentSprite:Node2D
@export var regular:CompressedTexture2D
@export var selected:CompressedTexture2D
@export var near:bool
@export var once:bool
@export var once2:bool = true
@export var sizeMult:float = 2
@onready var day_brain:DayBrain
@onready var dave:Dave
enum InteractType {Dialogue, Desk, EntryDoor, BossDoor}
@export var Type = InteractType.Dialogue
@export var readyToLeave:bool = false
@export var textToDisplay:String
@export var DialogueMarker:Node2D
@export var YarnNodeLink:String
@export var ScenePath:String
@export var animations:anim_brain



signal interacted


func _ready() -> void:
	parentSprite = self.get_parent()
	if get_tree().current_scene.get_node("DayBrain") != null:
		day_brain = get_tree().current_scene.get_node("DayBrain")
	if get_tree().current_scene.get_node("Dave") != null:
		dave = get_tree().current_scene.get_node("Dave")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact")&&once&&near):
		print(parentSprite.name+" interacted")
		interacted.emit()
		
		match Type:
			InteractType.Dialogue:
				day_brain.run_dialogue(YarnNodeLink,DialogueMarker)
				print("Asked Brain to start dialogue "+YarnNodeLink)
				if parentSprite is AnimatedSprite2D:
					parentSprite.play("open")
					dave._stopDave()
			InteractType.Desk:
				day_brain.enter_screen()
				dave._stopDave()
				print ("entering screen")
			InteractType.EntryDoor:
				if (readyToLeave):
					day_brain.end_day(textToDisplay,ScenePath)
					dave._stopDave()
			InteractType.BossDoor:
				if (!readyToLeave):
					day_brain.run_dialogue("PreBossDoor",DialogueMarker)
					dave._stopDave()
				else:
					day_brain.enter_boss()
					readyToLeave = false;
					dave._stopDave()
		
		once = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if animations !=null:
		animations.ResetSprites()
	near = true
	once = true
	if parentSprite is Sprite2D:
		parentSprite.texture = selected
	elif parentSprite is AnimatedSprite2D:
		print (parentSprite)
		parentSprite.play("selected")
		print("played selected")
	parentSprite.scale = 1.05*Vector2.ONE*sizeMult
	


func _on_area_2d_body_exited(_body: Node2D) -> void:
	near = false
	if parentSprite is Sprite2D:
		parentSprite.texture = regular
	elif parentSprite is AnimatedSprite2D:
		parentSprite.play("idle")
		print ("played idle")
	parentSprite.scale = Vector2.ONE*sizeMult
	once2 = true
	

func _interact():
		interacted.emit()
		print ("interacted has emitted")
		once2 = false
		
