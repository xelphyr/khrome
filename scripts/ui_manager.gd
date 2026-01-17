extends CanvasLayer
class_name UIManager

@export var splash : PackedScene
@export var level_select: PackedScene
@export var game : PackedScene
@export var pause : PackedScene

var state: Enum.UIState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_state(Enum.UIState.SPLASH)


func change_state(to: Enum.UIState):
	state = to
	for child in get_children(true):
		child.queue_free()
	match to:
		Enum.UIState.SPLASH:
			var instance = splash.instantiate()
			add_child(instance)
		Enum.UIState.LEVEL_SELECT:
			var instance = level_select.instantiate()
			add_child(instance)
		Enum.UIState.GAME:
			var instance = game.instantiate()
			add_child(instance)
	
