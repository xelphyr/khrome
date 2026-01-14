extends Node3D
class_name Level

@export var level_finish : Area3D
@export var level_idx : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not level_finish:
		print("LevelFinish not setup for this level! Set it up before using this level.")
	else:
		level_finish.body_entered.connect(_on_level_finish_body_entered)

func _on_level_finish_body_entered(body: Node3D):
	print("Body entered")
	if body.is_in_group(&"Player"):
		_level_end()

func _level_end():
	print("Body is player, ending level")
	EventBus.level_complete.emit()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
