extends Level
class_name Prologue

@export var dialogue_triggers : Array[Area3D]

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
		
	for i in range(dialogue_triggers.size()):
		dialogue_triggers[i].body_entered.connect(func(body): 
			if body.is_in_group("Player"):
				EventBus.prologue_trigger_dialogue.emit(i+1)
			)

