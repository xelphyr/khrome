extends Node
class_name LevelManager

@export var chapters : Array[Chapter]

var current_level_name : StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.load_level.connect(_load_level)
	EventBus.exit_level.connect(_unload)

func request_level_count(chapter:int) -> int:
	return chapters[chapter-1].levels.size()

##Requests the UUIDs of every level in the game
func request_uuids() -> Array[StringName]:
	var uuids : Array[StringName] = []
	for chapter in chapters:
		for level in chapter.levels:
			uuids.append(level.get_uuid())
	return uuids

##Requests the UUIDs of every level in a chapter
func request_chapter_uuids(chapter: int) -> Array[StringName]:
	var uuids : Array[StringName] = []
	for level in chapters[chapter-1].levels:
		uuids.append(level.get_uuid())
	return uuids

##Requests the UUIDs of a specific level
func request_level_uuid(chapter: int, level:int) -> StringName:
	return chapters[chapter-1].levels[level-1].get_uuid()

func unlock_next_level(chapter:int, level:int):
	if chapters[chapter-1].levels.size() == level:
		if chapters.size() > chapter:
			EventBus.progress_level_unlocked.emit(
				chapters[chapter].levels[0].get_uuid()
			)
	else:
		EventBus.progress_level_unlocked.emit(
			chapters[chapter-1].levels[level].get_uuid()
		)

func _load_level(chapter:int, level: int) -> void:
	for child in get_children():
		child.queue_free()

	var loaded_level = chapters[chapter-1].levels[level-1].get_scene().instantiate()
	current_level_name = chapters[chapter-1].levels[level-1].get_level_name()
	add_child(loaded_level)

func _unload() -> void:
	for child in get_children():
		child.queue_free()
