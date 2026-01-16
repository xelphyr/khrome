extends CharacterBody3D
class_name Player

@export var speed = 5.0
@export var jump_velocity = 10
@export var default_terminal_velocity : float = 200

var terminal_velocity = default_terminal_velocity

func _ready() -> void:
	EventBus.switch_to.connect(change_collision_layer)

func change_collision_layer(to: int) -> void:
	print(to)
	set_collision_layer_value(1, to==1)
	set_collision_layer_value(2, to==2)
	set_collision_mask_value(1, to==1)
	set_collision_mask_value(2, to==2)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_z+", "move_z-", "move_x+", "move_x-")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	velocity.x = tanh(velocity.x/terminal_velocity)*terminal_velocity
	velocity.y = tanh(velocity.y/terminal_velocity)*terminal_velocity
	velocity.z = tanh(velocity.z/terminal_velocity)*terminal_velocity

	move_and_slide()

func on_fan_entered(new_terminal_velocity : int):
	terminal_velocity = new_terminal_velocity

func on_fan_exited():
	terminal_velocity = default_terminal_velocity
