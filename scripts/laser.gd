extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"Player"):
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LASER)
		EventBus.level_failed.emit()
