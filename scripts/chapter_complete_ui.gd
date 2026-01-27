extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/MarginContainer/VBoxContainer/LevelComplete.start_display("CHAPTER %s COMPLETED" % GameManager.curr_chapter)
	if GameManager.curr_chapter == 1:
		$PanelContainer/MarginContainer/VBoxContainer/Indev.start_display(
		"UNLOCK PROLOGUE 1 BY SPEEDRUNNING\nALL THE LEVELS IN THIS CHAPTER\n(INDICATED BY A YELLOW BORDER AROUND THE LEVEL)\nYOU CAN STILL PLAY THE LEVELS OF THE OTHER CHAPTERS!")
	else:
		$PanelContainer/MarginContainer/VBoxContainer/Indev.start_display(
		"THE PROLOGUE IS STILL IN DEVELOPMENT\nYOU CAN STILL PLAY THE LEVELS OF THE OTHER CHAPTERS!")



func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	EventBus.exit_level.emit()
