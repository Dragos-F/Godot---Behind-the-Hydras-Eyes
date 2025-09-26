extends AnimatedSprite2D





func _on_area_2d_body_entered(body: Node2D) -> void:
	self.play("select")


func _on_area_2d_body_exited(body: Node2D) -> void:
	self.play("idle")
