extends Node
class_name LevelManager

@export var levels : Array[PackedScene] = [
]

var current_level : int = 1
var current_level_name : String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.load_level.connect(_load_level)
	EventBus.exit_level.connect(_unload)


func _load_level(level: int) -> void:
	current_level = level
	for child in get_children():
		child.queue_free()
	var loaded_level = levels[level-1].instantiate()
	current_level_name = loaded_level.name
	add_child(loaded_level)

func _unload() -> void:
	for child in get_children():
		child.queue_free()
