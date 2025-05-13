extends Node3D

@export var speed_scale: float = 1.0
@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("swipe")
	animation_player.speed_scale = speed_scale
