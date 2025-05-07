extends CharacterBody3D

@onready var _skin: SophiaSkin = %SophiaSkin


func _physics_process(delta: float) -> void:
		_skin.idle()
