extends StaticBody3D

var angular_speed := 1.0
var player: CharacterBody3D
#var player_remote_transform: RemoteTransform3D

func _process(delta):
	rotate_y(angular_speed * delta)

func _player_on_spike(body: Node3D) -> void:
	player = body
	player.player_dies()
