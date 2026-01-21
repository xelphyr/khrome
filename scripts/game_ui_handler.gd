extends Control
class_name GameUIHandler

const fade_time : float = 1
var cooldown : float = 0

enum State {DEFAULT, FADEIN, FADEOUT}
var curr_state = State.DEFAULT

var is_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.gameui_fadein_start.connect(func(): curr_state = State.FADEIN)
	EventBus.gameui_fadeout_start.connect(func(): curr_state = State.FADEOUT)
	EventBus.switch_to.connect(func(state): 
		if state == 1:
			$PhaseToGold.modulate = Color(255,255,255,0)
			$AnimationPlayer.play("PhaseToBlue")
		if state == 2:
			$PhaseToBlue.modulate = Color(255,255,255,0)
			$AnimationPlayer.play("PhaseToGold")
	)
	call_deferred("set_level_data")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_state == State.FADEIN:
		$Panel.modulate.a = lerpf(0.0, 1.0, cooldown/fade_time)
		cooldown += delta
		if cooldown >= fade_time:
			$Panel.modulate.a = 1.0
			cooldown = 0
			curr_state = State.DEFAULT
			reset_level_data()
			EventBus.gameui_fadein_end.emit()
	if curr_state == State.FADEOUT:
		$Panel.modulate.a = lerpf(1.0, 0.0, cooldown/fade_time)
		cooldown += delta
		if cooldown >= fade_time:
			$Panel.modulate.a = 0.0
			cooldown = 0
			curr_state = State.DEFAULT
			set_level_data()
			EventBus.gameui_fadeout_end.emit()
	
	if Input.is_action_just_pressed("pause"):
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
		if is_paused:
			resume() 
		else:
			pause()

func reset_level_data():
	$MarginContainer/VBoxContainer/LevelIndex.text = ""
	$MarginContainer/VBoxContainer/LevelName.text = ""

func set_level_data():
	print("Setting level texr")
	var level = get_tree().get_first_node_in_group(&"LevelManager").current_level
	var level_name = level.level_name
	var level_idx = level.level_idx

	$MarginContainer/VBoxContainer/LevelIndex.text = "Level %s" % level_idx
	$MarginContainer/VBoxContainer/LevelName.text = level_name.to_upper()

func pause():
	is_paused = true
	$PauseMenu.visible = true
	EventBus.pause_game.emit()

func resume():
	is_paused = false
	$PauseMenu.visible = false
	EventBus.resume_game.emit()


func _on_restart_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	resume()
	EventBus.level_failed.emit()


func _on_resume_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	resume()



func _on_menu_pressed() -> void:
	EventBus.exit_level.emit()
	
