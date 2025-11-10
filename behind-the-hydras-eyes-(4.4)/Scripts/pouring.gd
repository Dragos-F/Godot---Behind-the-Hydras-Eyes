extends Sprite2D
class_name containerPour

@export var pour_animation:AnimatedSprite2D
@export var pourAngle:float
@export var milk:bool 
@export var in_hand:bool = false
@export var pouring:bool = false
@export var oncev1:bool = true
@export var base_return:bool = false
@export var anchor_pos:Node2D
@export var pour_anim:String
@export var EndOfStream:Area2D
@export var ownSprite:Sprite2D
@export var selected: CompressedTexture2D
@export var regular:CompressedTexture2D
@export var openMilk: CompressedTexture2D
@export var brain:minigame_brain
@export var cowboyKettle:bool = false


func _process(_delta: float) -> void:
	if cowboyKettle:
		oncev1 = true
	if in_hand == true:
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",target,0.5)
		self.z_index = 2
		pour_animation.z_index = -2
	else:
		var target = anchor_pos.global_position
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",target,0.5)
		
func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and pouring:
		if oncev1:
			self.transform = self.transform.rotated(-pourAngle)
			pour_animation.visible = true
			pour_animation.play(pour_anim)
			oncev1 = false
			EndOfStream.monitorable = true
			if milk:
				ownSprite.texture = openMilk
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and pouring:
		oncev1 = true
		self.transform = self.transform.rotated(pourAngle)
		pour_animation.visible = false
		pouring = false
		EndOfStream.monitorable = false
	if in_hand && Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				in_hand = false
				self.position = anchor_pos.position
				self.z_index = 1
				brain.holding = false
				

func pick_up():
	in_hand = true
	brain.holding = true
	
	

func pour():
	pouring = true
	
	


func _on_area_2d_mouse_entered() -> void:
	ownSprite.texture = selected

func _on_kettle_mouse_exited() -> void:
	ownSprite.texture = regular



func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !in_hand&&!brain.holding:
		if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed():
			self.pick_up()
	elif in_hand and !pouring:
		if !base_return:
			if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed():
				pour()
		if base_return:
			if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed():
				in_hand = false
				self.position = anchor_pos.global_position
				self.z_index = 1
				brain.holding = false
				
				
	


#func _on_base_area_mouse_entered() -> void:
		#base_return = true
#
#
#func _on_base_area_mouse_exited() -> void:
		#base_return = false
