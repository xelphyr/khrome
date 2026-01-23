extends Node
class_name LevelManager

@export var levels_chapter_1 : Array[PackedScene] = [
]

@export var levels_chapter_2 : Array[PackedScene] = [
]

@export var levels_chapter_3 : Array[PackedScene] = [
]

@export var levels_chapter_4 : Array[PackedScene] = [
]


var current_level : int = 1
var current_level_name : String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.load_level.connect(_load_level)
	EventBus.exit_level.connect(_unload)

func request_level_count(chapter:int) -> int:
	if chapter==1:
		return levels_chapter_1.size()
	if chapter==2:
		return levels_chapter_2.size()
	if chapter==3:
		return levels_chapter_3.size()
	if chapter==4:
		return levels_chapter_4.size()
	assert(false)
	return 0

func _load_level(chapter:int, level: int) -> void:
	current_level = level
	for child in get_children():
		child.queue_free()

	var loaded_level

	if chapter==1:
		loaded_level = levels_chapter_1[level-1].instantiate()
	if chapter==2:
		loaded_level = levels_chapter_2[level-1].instantiate()
	if chapter==3:
		loaded_level = levels_chapter_3[level-1].instantiate()
	if chapter==4:
		loaded_level = levels_chapter_4[level-1].instantiate()

	current_level_name = loaded_level.name
	add_child(loaded_level)

func _unload() -> void:
	for child in get_children():
		child.queue_free()
