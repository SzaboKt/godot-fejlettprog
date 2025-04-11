extends CanvasLayer

@onready var _animation_player: AnimationPlayer = %AnimationPlayer

const FILE_BEGIN = "res://level/level_"

signal fade_complete

func play_fade(fade_out: bool = false) -> void:
		await get_tree().create_timer(1.0).timeout
		if not fade_out:
			_animation_player.play("fade_in", -1, 1.0)
		else:
			_animation_player.play_backwards("fade_in", 1.0)
		await _animation_player.animation_finished
		fade_complete.emit()

func _ready() -> void:
	Events.flag_reached.connect(play_fade)
