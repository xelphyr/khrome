extends Node

@export var curr_state : int = 1

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("switch"):
        curr_state = (curr_state)%2+1
        EventBus.switch_to.emit(curr_state)