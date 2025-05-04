extends StaticBody3D

var angular_speed := 1.0
var player: CharacterBody3D

func _process(delta):
	rotate_y(angular_speed * delta)

func attach_player(player):
	player.set_can_move(false)
	#player.get_parent().call_deferred("remove_child", player)
	#call_deferred("add_child", player)
	#player.global_transform = Transform3D.IDENTITY

func detach_player(player):
	call_deferred("remove_child", player)
	get_tree().current_scene.call_deferred("add_child", player)
	player.global_transform = global_transform * player.transform

func _player_on_spike(body: Node3D) -> void:
	attach_player(body)
