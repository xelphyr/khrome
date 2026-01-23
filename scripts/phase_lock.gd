extends StaticBody3D
class_name PhaseLock

@export var phase : int = 1
var disabled := false

func _ready() -> void:
	EventBus.phase_lock_unlock_enter.connect(func(): disabled = false)

func _on_detect_area_body_entered(body: Node3D) -> void:
	if not disabled and body.is_in_group(&"Player"):
		GameManager.lock_phase(phase)
		EventBus.phase_lock_unlock_enter.emit()
		disabled = true

