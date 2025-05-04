extends Node

const FILE_BEGIN = "res://level/level_"

@export var current_level: Node3D
@export var max_level_number: int
@onready var player: Player = $Player3DTemplate
@onready var flag_reached_screen: CanvasLayer = $FlagReachedScreen

var next_scene
var level_number: int = 1

func _ready() -> void:
	Events.flag_reached.connect(func on_flag_reached() -> void:
		player.set_can_move(false)
		if level_number == max_level_number:
			await flag_reached_screen.fade_complete
			get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")
		var next_level_number = level_number + 1
		level_number += 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		if not ResourceLoader.exists(next_level_path):
			printerr("Scene file does not exist: ", next_level_path)
			return
		await flag_reached_screen.fade_complete
		var next_scene = load(next_level_path)
		if next_scene:
			current_level.queue_free()
			add_child(next_scene.instantiate())
			player.global_position = Vector3.ZERO
			current_level = get_child(-1)
		else:
			printerr("Failed to load scene: ", next_level_path)
		flag_reached_screen.play_fade(true)
		await flag_reached_screen.fade_complete
		player.set_can_move(true)
		
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		get_viewport().mode = (
			Window.MODE_FULLSCREEN if
			get_viewport().mode != Window.MODE_FULLSCREEN else
			Window.MODE_WINDOWED
		)
