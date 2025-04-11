extends RigidBody3D

@export var impulse: float = 70.0
var player: CharacterBody3D
var direction: Vector3 

func _player_in_way(body: Node3D) -> void:
	body.push(global_position)


func _player_in_range(body: Node3D) -> void:
	direction = (body.global_position - global_position).normalized()
	apply_impulse(direction * impulse)
