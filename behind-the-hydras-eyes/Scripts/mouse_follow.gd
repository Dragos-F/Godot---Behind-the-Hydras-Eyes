extends Node2D
class_name holdable
@onready var minigame:minigame_brain = get_node("/root/TeaMinigame")
@onready var overMug:bool = false
func _ready() -> void:
	if minigame == null:
		minigame = get_node("/root/Main/TeaMinigame")

func _physics_process(_delta: float) -> void:
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position",target,0.3)
		self.z_index = 2
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			self.queue_free()
			minigame.holding = false
func put_in_mug(mug:mugBrain,type:int): # 0 for teabag, 1 for sugar
		if type == 0:
			mug.hasBag = true
			if mug.full and mug.newFill:
				mug.fillAnimation.play_backwards("tea")
				mug.fillAnimation.pause()
		if type == 1:
			mug.sugar +=1
			AudioBrain.playFX(mug.liquidDrop,false)
		minigame.holding = false
		self.queue_free()
	
