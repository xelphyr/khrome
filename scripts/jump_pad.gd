extends StaticBody3D

@export var jump_force : float = 50

func _on_enter_detect_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"Player"):
		body.velocity += global_transform.basis.y * jump_force


