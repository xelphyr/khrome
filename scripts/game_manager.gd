extends Node

var curr_state : int = 1
var curr_level : int = -1
var levels_count = 10

func _ready() -> void:
	EventBus.level_selected.connect(_on_level_selected)
	EventBus.level_complete.connect(_on_level_complete)
	EventBus.level_failed.connect(_on_level_failed)

	EventBus.gameui_fadein_end.connect(_on_gameui_fadein_end)
	EventBus.gameui_fadeout_end.connect(_on_gameui_fadeout_end)

	EventBus.pause_game.connect(_pause_game)
	EventBus.resume_game.connect(_resume_game)

func _pause_game():
	print("paused")
	get_tree().paused = true

func _resume_game():
	print("resume")
	get_tree().paused = false


func _on_level_selected(level: int):
	curr_level = level
	curr_state = 1
	EventBus.load_level.emit(level)
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LEVEL_ENTER)
	get_tree().paused = false

func _on_level_complete():
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.WIN)
	curr_level += 1
	EventBus.gameui_fadein_start.emit()

func _on_level_failed():
	curr_state = 1
	EventBus.load_level.emit(curr_level)
	
func _on_gameui_fadein_end():
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LEVEL_ENTER)
	if curr_level > levels_count:
		EventBus.exit_level.emit()
	else:
		EventBus.load_level.emit(curr_level)
		EventBus.gameui_fadeout_start.emit()
		curr_state = 1

func _on_gameui_fadeout_end():
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch"):
		curr_state = (curr_state)%2+1
		EventBus.switch_to.emit(curr_state) 
