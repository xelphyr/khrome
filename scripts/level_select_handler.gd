extends Control

var _current_chapter_value : int = 1
var current_chapter : int :
	get:
		return _current_chapter_value
	set(value):
		_current_chapter_value = value 
		_change_chapter(value)

var chapter_count : int
@onready var chapters = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer
@onready var chapter_scene : PackedScene = preload("res://scenes/ui/level_select/chapter.tscn")
@onready var previous_chapter : Button = $PanelContainer/MarginContainer/PreviousChapter
@onready var next_chapter : Button = $PanelContainer/MarginContainer/NextChapter

func initialize():
	current_chapter = 1

func _ready() -> void:
	chapter_count = get_tree().get_first_node_in_group("LevelManager").chapters.size()
	for i in range(chapter_count):
		var chapter = chapter_scene.instantiate() as ChapterSelectGrid
		chapter.chapter_index = i + 1
		chapters.call_deferred("add_child", chapter)
		chapter.level_selected.connect(_level_selected)
	call_deferred("initialize")


func _level_selected(chapter: int, level: int):
	#AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	EventBus.level_selected.emit(chapter, level)
	UIManager.call("change_state", Enum.UIState.GAME)


func _change_chapter(to:int):
	for i in range(chapters.get_child_count()):
		chapters.get_child(i).visible = (to-1)==i

func _on_next_chapter_pressed() -> void:
	if current_chapter >= 4:
		next_chapter.disabled = true
	else:
		AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
		current_chapter += 1
		previous_chapter.disabled = false
		if current_chapter >= 4:
			next_chapter.disabled = true

func _on_previous_chapter_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.BUTTON_SELECT)
	if current_chapter <= 1:
		previous_chapter.disabled = true
	else:
		current_chapter -= 1
		next_chapter.disabled = false
		if current_chapter <= 1:
			previous_chapter.disabled = true
