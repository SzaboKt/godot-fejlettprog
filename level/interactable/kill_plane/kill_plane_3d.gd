extends Area3D


func _ready() -> void:
	body_entered.connect(func (_body_that_entered: PhysicsBody3D) -> void:
		if _body_that_entered is Player:
			await get_tree().process_frame
			Events.kill_plane_touched.emit()
		else:
			_body_that_entered.queue_free()
	)
