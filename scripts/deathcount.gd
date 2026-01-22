extends Label
class_name DeathCount

var death_count : int:
	set(value):
		death_count = value
		_update_display(value)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death_count = 0
	EventBus.level_failed.connect(func(): death_count = death_count+ 1)
	EventBus.gameui_fadeout_start.connect(func(): death_count = 0)


func _update_display(value:int):
	$AnimationPlayer.play("DeathIncrement")
	text = "%02d" % value
