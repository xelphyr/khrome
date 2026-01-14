extends Node

@export var curr_state : int = 1
@export var levels : Dictionary[int, PackedScene] = {
	1: preload("res://scenes/levels/1.tscn")
}

func _ready() -> void:
	EventBus.level_selected.connect(_load_level)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch"):
		curr_state = (curr_state)%2+1
		EventBus.switch_to.emit(curr_state) 

func _load_level(level: int):
	var loaded_level = levels[level].instantiate()
	get_tree().current_scene.call_deferred("add_child", loaded_level)

