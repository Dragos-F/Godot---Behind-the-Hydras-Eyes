extends Area2D
@export var targetGroup:Node2D
@export var inValue:int
@export var outValue:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	targetGroup.z_index = inValue
	


func _on_body_exited(body: Node2D) -> void:
	targetGroup.z_index = outValue
