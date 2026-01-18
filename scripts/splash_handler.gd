extends Control


func _on_play_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	UIManager.call("change_state", Enum.UIState.LEVEL_SELECT)
