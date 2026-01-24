extends StaticBody3D

@export var jump_force : float = 50
var xz_mult = 2

func _on_enter_detect_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"Player"):
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.JUMP_PAD)
		body.velocity += global_transform.basis.y * jump_force * Vector3(xz_mult,1,xz_mult)

		
