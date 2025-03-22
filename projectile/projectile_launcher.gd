extends Node3D

const PROJECTILE = preload("res://projectile/projectile.tscn")

@onready var cool_down_timer: Timer = $CoolDownTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var player: CharacterBody3D

#func _ready() -> void:
	#var shooting_animation: Animation = animation_player.get_animation("1H_Ranged_Shooting")
	#var reloading_animation: Animation = animation_player.get_animation("1H_Ranged_Reload")
	#shooting_timer.wait_time = shooting_animation.length
	#cool_down_timer.wait_time = reloading_animation.length

func _physics_process(delta: float) -> void:
	if player:
		if cool_down_timer.is_stopped():
				cool_down_timer.start()
				var attack = PROJECTILE.instantiate()
				add_child(attack)
				attack.global_transform = global_transform
		#if shooting_timer
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	player = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	player = null
