class_name ProjectileLauncher extends Node3D

var PROJECTILE: Resource

@onready var cool_down_timer: Timer = $CoolDownTimer
#@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var automatic: bool = false
@export var arrow_type: String

@export var wait_time: float = 2.5
var player: CharacterBody3D

func _ready() -> void:
	if arrow_type == "Rouge":
		PROJECTILE = preload("res://projectile/projectile.tscn")
	elif arrow_type == "Snow":
		PROJECTILE = preload("res://projectile/snow_projectile.tscn")
	cool_down_timer.wait_time = wait_time

func _physics_process(delta: float) -> void:
	if automatic or (!automatic and player):
		if cool_down_timer.is_stopped() and wait_time > 0:
			cool_down_timer.wait_time = wait_time
			cool_down_timer.start()
			var attack = PROJECTILE.instantiate()
			add_child(attack)
			attack.global_transform = global_transform

func _on_area_3d_body_entered(body: Node3D) -> void:
	player = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	player = null
