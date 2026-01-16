extends StaticBody3D

@export var spin_speed : float
@export var rotate_vector : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += rotate_vector*spin_speed*delta
