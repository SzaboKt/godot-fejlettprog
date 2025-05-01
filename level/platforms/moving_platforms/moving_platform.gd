extends Path3D

@export var loop: bool = true
@export var speed: float = 20.0
@export var speed_scale: float = 1.0

@onready var path_follow_3d: PathFollow3D = $PathFollow3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not loop:
		animation_player.play("move")
		animation_player.speed_scale = speed_scale
		set_process(false)

func _process(delta: float) -> void:
	path_follow_3d.progress += speed
