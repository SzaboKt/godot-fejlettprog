extends CharacterBody3D
class_name Rouge

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var rotation_speed: float = 5.0
@export var acceleration: float = 20.0

@onready var gravity: float = -ProjectSettings.get_setting("physics/3d/default_gravity")
var wander_time: float
var move_direction: Vector3
@onready var _skin := $Rig

func randomize_wander():
	wander_time = randf_range(1, 3)
	var local_to_global_basis: Basis = global_transform.basis
	var random_point := Vector3(position.x + randf_range(-10, 10), position.y, position.z + randf_range(-10, 10))
	var global_random_point = local_to_global_basis * random_point
	var move_to = global_random_point - global_position
	move_direction = move_to.normalized()
	move_direction.y = 0
	look_at(global_random_point, Vector3(0,1,0), true)
	
func _ready() -> void:
	randomize_wander()

func _physics_process(delta: float) -> void:
	velocity = move_direction * speed
	velocity.y += gravity
	
	if wander_time < 0:
		randomize_wander()
		
	wander_time -= delta
	
	if velocity.length() > 0:
		$AnimationPlayer.play("Walking_B")
	
	if velocity.normalized() == Vector3(0, -1, 0):
		$AnimationPlayer.play("Unarmed_Pose")
	
	move_and_slide()
