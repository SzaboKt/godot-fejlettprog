extends Node3D


@onready var projectile_launcher: ProjectileLauncher = $ProjectileLauncher

@export var wait_time: float = 0

func _ready() -> void:
	projectile_launcher.wait_time = wait_time
	#print(projectile_launcher.cool_down_timer.wait_time)
