extends AnimatedSprite2D


@export_enum("Doc","Cat","Update") var anim:String


func _ready() -> void:
	self.play(anim)
