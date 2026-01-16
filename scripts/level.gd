extends Node3D
class_name Level

@export var level_finish : Area3D
@export var fall_detect : Area3D
@export var start : Node3D
@export var level_idx : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not level_finish:
		print("LevelFinish not setup for this level! Set it up before using this level.")
	else:
		level_finish.body_entered.connect(_on_level_finish_body_entered)

	if not fall_detect:
		print("FallDetect not setup for this level! Set it up before using this level.")
	else:
		fall_detect.body_entered.connect(_on_fall_detect_body_entered)
	
	if not start:
		print("Start Point not setup for this level! Set it up before using this level.")

func _on_level_finish_body_entered(body: Node3D):
	if body.is_in_group(&"Player"):
		_level_end(body)

func _on_fall_detect_body_entered(body: Node3D):
	if body.is_in_group(&"Player"):
		_level_failed()

func _level_failed():
	EventBus.level_failed.emit()

func _level_end(body: CharacterBody3D):
	print("Body is player, ending level")
	body.process_mode = Node.PROCESS_MODE_DISABLED
	EventBus.level_complete.emit()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
