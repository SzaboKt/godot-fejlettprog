extends RayCast3D

@export var speed: float = 30.0

@onready var remote_transform: RemoteTransform3D = RemoteTransform3D.new()

func _ready() -> void:
	Events.kill_plane_touched.connect(_on_kill_plane_touched)

func _on_kill_plane_touched() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * speed * delta
	target_position = Vector3.FORWARD * speed * delta
	force_raycast_update()
	var collider = get_collider()
	if is_colliding():
		global_position = get_collision_point()
		set_physics_process(false)
		if collider is Player:
			collider.get_skin().add_child(remote_transform)
			collider.push(global_position)
		else:
			collider.add_child(remote_transform)
		remote_transform.global_transform = global_transform
		remote_transform.remote_path = remote_transform.get_path_to(self)
		remote_transform.tree_exited.connect(queue_free)

func _on_timer_timeout() -> void:
	queue_free()
