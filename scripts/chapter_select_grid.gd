extends VBoxContainer
class_name ChapterSelectGrid

var button_scene = preload("res://scenes/ui/level_select/level.tscn")
var chapter_index : int
var chapter_button_group : ButtonGroup = ButtonGroup.new()

signal level_selected(chapter:int, level:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var uuids : Array[StringName] = get_tree().get_first_node_in_group("LevelManager").request_chapter_uuids(chapter_index)
	for level in range(uuids.size()):
		var button = button_scene.instantiate() as CheckBox
		button.text = str(level+1)
		button.name = str(level+1)
		button.disabled = not ProgressManager.check_level_unlocked(uuids[level])
		button.button_group = chapter_button_group
		$Buttons.call_deferred("add_child", button)
	chapter_button_group.pressed.connect(_on_button_group_pressed)
	

func _on_button_group_pressed(button: BaseButton):
	level_selected.emit(chapter_index, button.name.to_int())
