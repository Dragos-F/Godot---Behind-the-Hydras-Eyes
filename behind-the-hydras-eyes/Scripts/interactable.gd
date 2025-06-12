extends Node2D
class_name Interactable
@export var parentSprite:Sprite2D
@export var regular:CompressedTexture2D
@export var selected:CompressedTexture2D
@export var near:bool
@export var once:bool
@export var once2:bool = true
@export var sizeMult:float = 2
@onready var day_brain:DayBrain
enum InteractType {Yarn, Desk, EntryDoor, BossDoor}
@export var Type = InteractType.Yarn
@export var readyToLeave:bool = false
@export var textToDisplay:String


@export var YarnNodeLink:String



signal interacted
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	parentSprite = self.get_parent()
	day_brain = get_tree().current_scene.get_node("DayBrain")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")&&once&&near):
		print(parentSprite.name+" interacted")
		interacted.emit()
		match Type:
			InteractType.Yarn:
				day_brain.run_dialogue(YarnNodeLink)
				print("Asked Brain to start dialogue "+YarnNodeLink)
			InteractType.Desk:
				pass
			InteractType.EntryDoor:
				if (readyToLeave):
					day_brain.end_day(textToDisplay)
			InteractType.BossDoor:
				if (!readyToLeave):
					day_brain.run_dialogue("PreBossDoor")
				else:
					day_brain.enter_boss()
					readyToLeave = false;
		
		once = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	near = true
	once = true
	parentSprite.texture = selected
	parentSprite.scale = 1.05*Vector2.ONE*sizeMult
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	near = false
	parentSprite.texture = regular
	parentSprite.scale = Vector2.ONE*sizeMult
	once2 = true
	

func _interact():
		interacted.emit()
		print ("interacted has emitted")
		once2 = false
		
