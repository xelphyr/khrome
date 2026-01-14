extends Control


func _on_play_pressed() -> void:
	get_parent().call("change_state", Enum.UIState.LEVEL_SELECT)
