extends CharacterBody3D
class_name Rouge

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var rotation_speed: float = 5.0
@export var acceleration: float = 20.0
@export var push_speed: float = 20.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var gravity: float = -ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _skin := $Rig
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var idle_timer: Timer = $IdleTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var state_machine := animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback

var wander_time: float
var move_direction: Vector3
var bake_finished: bool = false
var player: Player
var being_pushed: bool = false

func randomize_wander():
	var random_point := Vector3(randf_range(-1000, 1000), 0, randf_range(-1000, 1000))
	navigation_agent_3d.set_target_position(random_point)

func randomize_idle():
	var random_time: float = randf_range(0.5, 2)
	idle_timer.start(random_time)

func _ready() -> void:
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)
	animation_tree.active = true
	randomize_idle()

func _physics_process(delta: float) -> void:
	if player:
		look_at(player.global_position, Vector3(0,1,0), true)
		animation_tree["parameters/conditions/is_shooting"] = true
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_walking"] = false
		if state_machine.get_current_node() == "Walking_B":
			velocity = Vector3.ZERO
	#elif being_pushed:
		#print(velocity)
		#move_toward(velocity.x, 0.0, delta)
		#move_toward(velocity.z, 0.0, delta)
	else:
		animation_tree["parameters/conditions/is_shooting"] = false
		if idle_timer.is_stopped() and not state_machine.get_current_node() in ["1H_Ranged_Shoot", "1H_Ranged_Reload"]:
			animation_tree["parameters/conditions/idle"] = false
			animation_tree["parameters/conditions/is_walking"] = true
			var destination: Vector3 = navigation_agent_3d.get_next_path_position()
			destination.y = global_position.y
			var move_to: Vector3 = destination - global_position
			move_direction = move_to.normalized()
			move_direction.y = 0
			if move_to != Vector3(0, 0, 0):
				look_at(destination, Vector3(0,1,0), true)
			velocity = move_direction * speed
		else:
			animation_tree["parameters/conditions/idle"] = true
			animation_tree["parameters/conditions/is_walking"] = false
			velocity = Vector3.ZERO
	
	#if state_machine.get_current_node() in ["1H_Ranged_Reload", "1H_Ranged_Shoot"]:
		#velocity = Vector3.ZERO
	#if velocity.normalized() == Vector3(0, -1, 0):
		#$AnimationPlayer.play("Unarmed_Pose")
	velocity.y += gravity
	move_and_slide()

func _on_navigation_agent_3d_navigation_finished() -> void:
	randomize_idle()
	
func push() -> void:
	being_pushed = true
	velocity += -global_transform.basis.z * push_speed

func _on_area_3d_body_entered(body: Node3D) -> void:
	player = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	player = null

func _on_idle_timer_timeout() -> void:
	randomize_wander()
