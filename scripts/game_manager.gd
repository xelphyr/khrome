extends Node

var curr_state : int = 1
var curr_level : int = -1

func _ready() -> void:
	EventBus.level_selected.connect(_on_level_selected)
	EventBus.level_complete.connect(_on_level_complete)

	EventBus.gameui_fadein_end.connect(_on_gameui_fadein_end)
	EventBus.gameui_fadeout_end.connect(_on_gameui_fadeout_end)

func _on_level_selected(level: int):
	curr_level = level
	EventBus.load_level.emit(level)


func _on_level_complete():
	curr_level += 1
	EventBus.gameui_fadein_start.emit()
	
func _on_gameui_fadein_end():
	EventBus.load_level.emit(curr_level)
	EventBus.gameui_fadeout_start.emit()

func _on_gameui_fadeout_end():
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch"):
		curr_state = (curr_state)%2+1
		EventBus.switch_to.emit(curr_state) 
