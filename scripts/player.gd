extends CharacterBody3D
class_name Player

@export var drag = 70.0
@export var speed = 5.0
@export var jump_velocity = 10
@export var default_terminal_velocity : float = 200
@export var blue_phase_mat : Material
@export var gold_phase_mat : Material

var start_movement = false

var curr_grid_enabled : int :
	set(value):
		curr_grid_enabled = value
		change_grid_enabled(value)

var num_fans = 0
var terminal_velocity = default_terminal_velocity

func _ready() -> void:
	EventBus.switch_to.connect(change_collision_layer)
	curr_grid_enabled = 0

func change_collision_layer(to: int) -> void:
	print(to)
	set_collision_layer_value(1, to==1)
	set_collision_layer_value(2, to==2)
	set_collision_mask_value(1, to==1)
	set_collision_mask_value(2, to==2)

	if to == 1:
		$MeshInstance3D2.set_surface_override_material(0, blue_phase_mat)
	if to == 2:
		$MeshInstance3D2.set_surface_override_material(0, gold_phase_mat)

	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.PHASE_SWITCH)

func _physics_process(delta: float) -> void:
	#Step 1: get the movement vector
	var input_dir := Input.get_vector("move_z+", "move_z-", "move_x+", "move_x-")
	if input_dir != Vector2.ZERO and start_movement == false:
		start_movement = true 
		EventBus.player_movement_started.emit()


	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	#Step 2: get the gravity
	var gravity := get_gravity()

	#Step 3: gravity-velocity combinations for each direction
	if gravity.x == 0:
		if direction:
			if abs(direction.x * speed) > abs(velocity.x):
				velocity.x = direction.x * speed
			else:
				velocity.x = move_toward(velocity.x, direction.x * speed, drag*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, drag*delta)
	else:
		velocity.x += gravity.x * delta
	if gravity.z == 0:
		if direction:
			if abs(direction.z * speed) > abs(velocity.z):
				velocity.z = direction.z * speed
			else:
				velocity.z = move_toward(velocity.z, direction.z * speed, drag*delta)
		else:
			velocity.z = move_toward(velocity.z, 0, drag*delta)
	else:
		velocity.z += gravity.z * delta

	if not is_on_floor():
		if get_gravity().y == 0:
			velocity.y = move_toward(velocity.y, 0, drag*delta)
		else:	
			velocity.y += get_gravity().y * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		if start_movement == false:
			start_movement = true 
			EventBus.player_movement_started.emit()
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.JUMP)
		velocity.y = jump_velocity

	#Step 4: max speed
	velocity.x = tanh(velocity.x/terminal_velocity)*terminal_velocity
	velocity.y = tanh(velocity.y/terminal_velocity)*terminal_velocity
	velocity.z = tanh(velocity.z/terminal_velocity)*terminal_velocity

	move_and_slide()

func change_grid_enabled(value:int):
	if value == 0:
		$GraphX.visible = false
		$GraphY.visible = false
		$GraphZ.visible = false
	if value == 1:
		$GraphX.visible = not $GraphX.visible 
		$GraphY.visible = false
		$GraphZ.visible = false
	if value == 2:
		$GraphX.visible = false
		$GraphY.visible = false
		$GraphZ.visible = not $GraphZ.visible 
	if value == 3:
		$GraphX.visible = false
		$GraphY.visible = not $GraphY.visible 
		$GraphZ.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cycle_grid_forward"):
		curr_grid_enabled = posmod(curr_grid_enabled + 1, 4)
	if Input.is_action_just_pressed("cycle_grid_backward"):
		curr_grid_enabled = posmod(curr_grid_enabled - 1, 4)

func on_fan_entered(new_terminal_velocity : int):
	terminal_velocity = new_terminal_velocity
	num_fans += 1

func on_fan_exited():
	terminal_velocity = default_terminal_velocity
	num_fans = max(0, num_fans-1)



##	# Handle jump.
##	if Input.is_action_just_pressed("jump") and is_on_floor():
##		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.JUMP)
##		velocity.y = jump_velocity
##
##	# Get the input direction and handle the movement/deceleration.
##	# As good practice, you should replace UI actions with custom gameplay actions.
##	var input_dir := Input.get_vector("move_z+", "move_z-", "move_x+", "move_x-")
##	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
##	if direction:
##		velocity.x = direction.x * speed
##		velocity.z = direction.z * speed
##	else:
##		velocity.x = move_toward(velocity.x, 0, speed)
##		velocity.z = move_toward(velocity.z, 0, speed)
##	
##	if get_gravity().y == 0:
##		velocity.y = move_toward(velocity.y, 0, speed*delta)
##	
##	# Add the gravity.
##	if not is_on_floor():
##		velocity += get_gravity() * delta
##
##	velocity.x = tanh(velocity.x/terminal_velocity)*terminal_velocity
##	velocity.y = tanh(velocity.y/terminal_velocity)*terminal_velocity
##	velocity.z = tanh(velocity.z/terminal_velocity)*terminal_velocity
