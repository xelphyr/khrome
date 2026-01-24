extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/MarginContainer/VBoxContainer/LevelComplete.start_display("CHAPTER %s COMPLETED" % GameManager.curr_chapter)
	$PanelContainer/MarginContainer/VBoxContainer/Indev.start_display(
		"THE PROLOGUE IS STILL IN DEVELOPMENT\nYOU CAN STILL PLAY THE LEVELS OF THE OTHER CHAPTERS!")



func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	EventBus.exit_level.emit()
