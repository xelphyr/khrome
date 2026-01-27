extends Node

var curr_state : int = 1
var curr_level : int = -1
var curr_chapter : int = 1
var chapter_levels_count = 10

var phase_locked := false

@onready var level_manager = get_tree().get_first_node_in_group(&"LevelManager") as LevelManager

func _ready() -> void:
	EventBus.level_selected.connect(_on_level_selected)
	EventBus.level_complete.connect(_on_level_complete)
	EventBus.level_failed.connect(_on_level_failed)

	EventBus.gameui_fadein_end.connect(_on_gameui_fadein_end)
	EventBus.gameui_fadeout_end.connect(_on_gameui_fadeout_end)

	EventBus.pause_game.connect(_pause_game)
	EventBus.resume_game.connect(_resume_game)

	EventBus.prologue_selected.connect(_on_prologue_selected)

func _pause_game():
	print("paused")
	get_tree().paused = true

func _resume_game():
	print("resume")
	get_tree().paused = false

func _on_prologue_selected(chapter:int):
	curr_state = 1
	curr_chapter = chapter
	phase_locked = false

	EventBus.load_prologue.emit(chapter)
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LEVEL_ENTER)
	get_tree().paused = false

func _on_level_selected(chapter:int, level: int):
	curr_level = level
	curr_state = 1
	curr_chapter = chapter
	phase_locked = false
	var num_levels = get_tree().get_first_node_in_group(&"LevelManager").request_level_count(chapter)

	if level > num_levels:
		assert(false, "THAT LEVEL ISNT IMPLEMENTED YET AAAAAAAAAAAAAAAA")
	else:
		chapter_levels_count = num_levels
		EventBus.load_level.emit(chapter, level)
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LEVEL_ENTER)
		get_tree().paused = false

func _on_level_complete():
	phase_locked = false
	
	EventBus.phase_lock_unlock_enter.emit()

	if UIManager.state == Enum.UIState.GAME:
		var curr_level_uuid = level_manager.current_level_data.get_uuid()
		EventBus.progress_level_completed.emit(curr_level_uuid)
		level_manager.unlock_next_level(curr_chapter, curr_level)

		var user_time = UIManager.displayed_ui.timer.seconds_elapsed
		var speedrun_time = level_manager.current_level_data.get_speedrun_time()
		if user_time <= speedrun_time:
			EventBus.progress_level_speedran.emit(curr_level_uuid)

	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.WIN)
	curr_level += 1
	EventBus.gameui_fadein_start.emit()

func _on_level_failed():
	phase_locked = false
	EventBus.phase_lock_unlock_enter.emit()
	curr_state = 1
	if UIManager.state == Enum.UIState.PROLOGUE:
		EventBus.load_prologue.emit(curr_chapter)
	else:
		EventBus.load_level.emit(curr_chapter, curr_level)

func _on_gameui_fadein_end():
	if UIManager.state == Enum.UIState.PROLOGUE:
		EventBus.exit_level.emit()
	else:
		print("curr_level: ", curr_level)
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.LEVEL_ENTER)
		if curr_level > chapter_levels_count:
			get_tree().paused = true
			UIManager.change_state(Enum.UIState.CHAPTER_COMPLETE)
		else:
			EventBus.load_level.emit(curr_chapter, curr_level)
			EventBus.gameui_fadeout_start.emit()
			curr_state = 1

func _on_gameui_fadeout_end():
	pass

func lock_phase(to: int):
	phase_locked = true
	curr_state = to
	EventBus.switch_to.emit(to)

func unlock_phase(to: int):
	phase_locked = false
	EventBus.switch_to.emit(to)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch") and not phase_locked:
		if \
		(UIManager.displayed_ui.name == "GameMenu" or UIManager.displayed_ui.name == "PrologueUI")\
		and (UIManager.displayed_ui.curr_state == UIManager.displayed_ui.State.DEFAULT or UIManager.displayed_ui.curr_state == UIManager.displayed_ui.State.FADEOUT):
			curr_state = (curr_state)%2+1
			EventBus.switch_to.emit(curr_state) 
