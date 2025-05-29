extends Node2D
@export var parentSprite:Sprite2D
@export var regular:CompressedTexture2D
@export var selected:CompressedTexture2D
@export var near:bool
@export var once:bool
@export var sizeMult:float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parentSprite = self.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")&&once):
		print(parentSprite.name+" interacted")
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
