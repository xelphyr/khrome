extends Node
class_name LevelManager

@export var levels : Dictionary[int, PackedScene] = {
	1: preload("res://scenes/levels/1.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.load_level.connect(_load_level)
	EventBus.exit_level.connect(_unload)


func _load_level(level: int) -> void:
	for child in get_children():
		child.queue_free()
	var loaded_level = levels[level].instantiate()
	add_child(loaded_level)

func _unload() -> void:
	for child in get_children():
		child.queue_free()
