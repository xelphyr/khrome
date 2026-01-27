extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_selected.connect(func(_e, _a): stop())
	EventBus.prologue_selected.connect(func(_e): stop())
	EventBus.exit_level.connect(play)
	play()



