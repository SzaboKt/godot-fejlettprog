extends Node3D

@export var emitting: bool = false

func emit_particles() -> void:
	for child in get_children():
		child.emitting = true

func _ready() -> void:
	Events.kill_plane_touched.connect(emit_particles)
	Events.player_dies.connect(emit_particles)
	pass
