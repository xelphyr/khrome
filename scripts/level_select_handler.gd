extends Control




var _current_chapter_value : int = 1
var current_chapter : int :
	get:
		return _current_chapter_value
	set(value):
		_current_chapter_value = value 
		_change_chapter(value)

@onready var chapter_1 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Chapter1
@onready var chapter_2 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Chapter2
@onready var chapter_3 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Chapter3
@onready var chapter_4 = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Chapter4

@onready var chapter_1_button_grid = chapter_1.get_child(1)
@onready var chapter_2_button_grid = chapter_2.get_child(1)
@onready var chapter_3_button_grid = chapter_3.get_child(1)
@onready var chapter_4_button_grid = chapter_4.get_child(1)

var chapter_1_level_select_buttons : ButtonGroup = ButtonGroup.new()
var chapter_2_level_select_buttons : ButtonGroup = ButtonGroup.new()
var chapter_3_level_select_buttons : ButtonGroup = ButtonGroup.new()
var chapter_4_level_select_buttons : ButtonGroup = ButtonGroup.new()

func _ready() -> void:
	for button in chapter_1_button_grid.get_children():
		button.button_group = chapter_1_level_select_buttons
	for button in chapter_2_button_grid.get_children():
		button.button_group = chapter_2_level_select_buttons
	for button in chapter_3_button_grid.get_children():
		button.button_group = chapter_3_level_select_buttons
	for button in chapter_4_button_grid.get_children():
		button.button_group = chapter_4_level_select_buttons
	chapter_1_level_select_buttons.pressed.connect(_level_selected_ch_1)
	chapter_2_level_select_buttons.pressed.connect(_level_selected_ch_2)
	chapter_3_level_select_buttons.pressed.connect(_level_selected_ch_3)
	chapter_4_level_select_buttons.pressed.connect(_level_selected_ch_4)

	current_chapter = 1

func _level_selected_ch_1(button: BaseButton):
	#AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	print("level selected in ch 1: ", button.name)
	EventBus.level_selected.emit(1, button.name.to_int())
	UIManager.call("change_state", Enum.UIState.GAME)

func _level_selected_ch_2(button: BaseButton):
	#AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	print("level selected in ch 2: ", button.name)
	EventBus.level_selected.emit(2, button.name.to_int())
	UIManager.call("change_state", Enum.UIState.GAME)

func _level_selected_ch_3(button: BaseButton):
	#AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	print("level selected in ch 3: ", button.name)
	EventBus.level_selected.emit(3, button.name.to_int())
	UIManager.call("change_state", Enum.UIState.GAME)

func _level_selected_ch_4(button: BaseButton):
	#AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	print("level selected in ch 4: ", button.name)
	EventBus.level_selected.emit(4, button.name.to_int())
	UIManager.call("change_state", Enum.UIState.GAME)

func _change_chapter(to:int):
	chapter_1.visible = to==1
	chapter_2.visible = to==2
	chapter_3.visible = to==3
	chapter_4.visible = to==4

func _on_next_chapter_pressed() -> void:
	if current_chapter >= 4:
		$PanelContainer/MarginContainer/NextChapter.disabled = true
	else:
		current_chapter += 1
		$PanelContainer/MarginContainer/PreviousChapter.disabled = false
		if current_chapter >= 4:
			$PanelContainer/MarginContainer/NextChapter.disabled = true

func _on_previous_chapter_pressed() -> void:
	if current_chapter <= 1:
		$PanelContainer/MarginContainer/PreviousChapter.disabled = true
	else:
		current_chapter -= 1
		$PanelContainer/MarginContainer/NextChapter.disabled = false
		if current_chapter <= 1:
			$PanelContainer/MarginContainer/PreviousChapter.disabled = true
