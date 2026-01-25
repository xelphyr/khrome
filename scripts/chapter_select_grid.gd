extends VBoxContainer
class_name ChapterSelectGrid

var button_scene = preload("res://scenes/ui/level_select/level.tscn")
var chapter_index : int
var chapter_button_group : ButtonGroup = ButtonGroup.new()
var unlocked_theme = preload("res://assets/themes/level_select_button_unlocked.tres")
var completed_theme = preload("res://assets/themes/level_select_button_completed.tres")
var speedran_theme = preload("res://assets/themes/level_select_button_speedran.tres")

signal level_selected(chapter:int, level:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_manager = get_tree().get_first_node_in_group("LevelManager")
	var uuids : Array[StringName] = level_manager.request_chapter_uuids(chapter_index)
	$Label.text = "Chapter %d: %s" % [chapter_index, level_manager.chapters[chapter_index-1].chapter_name.to_upper()]
	for level in range(uuids.size()):
		var button = button_scene.instantiate() as CheckBox
		button.text = str(level+1)
		button.name = str(level+1)
		if ProgressManager.check_level_speedran(uuids[level]):
			button.theme = speedran_theme
		elif ProgressManager.check_level_completed(uuids[level]):
			button.theme = completed_theme
		elif ProgressManager.check_level_unlocked(uuids[level]):
			button.theme = unlocked_theme
		else:
			button.theme = unlocked_theme
			button.disabled = true
		button.button_group = chapter_button_group
		$Buttons.call_deferred("add_child", button)
	chapter_button_group.pressed.connect(_on_button_group_pressed)
	

func _on_button_group_pressed(button: BaseButton):
	level_selected.emit(chapter_index, button.name.to_int())
