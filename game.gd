extends Node

const FILE_BEGIN = "res://level/level_"

@export var max_level_number: int
@export var current_level_number: int
@onready var player: Player = $Player3DTemplate
@onready var flag_reached_screen: CanvasLayer = $FlagReachedScreen


func load_level() -> void:
	
	if current_level_number > max_level_number:
		get_tree().change_scene_to_file("res://title_screen/menu.tscn")
	
	var level_path = FILE_BEGIN + str(current_level_number) + ".tscn"
	print(level_path)
	if not ResourceLoader.exists(level_path):
		printerr("Scene file does not exist: ", level_path)
		return
	print("asd0")
	
	var current_scene = load(level_path)
	
	if get_child(-1) is Node3D:
		print("asd")
		get_child(-1).queue_free()
	else:
		print("No previous node found.")
		
	if current_scene:
		print("asd")
		add_child(current_scene.instantiate())
		player.global_position = Vector3.ZERO
	else:
		printerr("Failed to load scene: ", level_path)
	flag_reached_screen.play_fade(true)
	

func _ready() -> void:
	load_level()
	Events.flag_reached.connect(func on_flag_reached() -> void:
		player.set_can_move(false)
		current_level_number += 1
		await flag_reached_screen.fade_complete
		load_level()
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
