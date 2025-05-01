extends RigidBody3D

@export var navigation_agent_3d: NavigationAgent3D
@export var impulse: int
var player: CharacterBody3D
@export var patience_counter: int = 20
var counter: int = 0

func _player_in_way(body: Node3D) -> void:
	body.push(global_position)

func _player_in_range(body: Node3D) -> void:
	player = body
	navigation_agent_3d.set_target_position(player.global_position)
	counter = patience_counter
	
func _physics_process(delta: float) -> void:
	if player and linear_velocity.y >= 0:
		if counter > patience_counter:
			navigation_agent_3d.set_target_position(player.global_position)
			var destination: Vector3 = navigation_agent_3d.get_next_path_position()
			var direction = (destination - global_position).normalized()
			apply_impulse(direction * impulse)
			counter = 0
		else:
			counter += 1
		
