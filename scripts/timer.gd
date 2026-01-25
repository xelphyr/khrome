extends Label
class_name Clock

var _raw_seconds_elapsed : float
var seconds_elapsed : float :
	get:
		return _raw_seconds_elapsed
	set(value):
		_raw_seconds_elapsed = value
		update_display(value)
		 

var timer_running : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.player_movement_started.connect(start_clock)
	EventBus.level_complete.connect(stop_clock)
	EventBus.pause_game.connect(stop_clock)
	EventBus.resume_game.connect(resume_clock)
	EventBus.level_failed.connect(restart_clock)
	EventBus.load_level.connect(restart_clock)

func _process(delta: float) -> void:
	if timer_running:
		seconds_elapsed += delta

func start_clock():
	seconds_elapsed = 0
	timer_running = true

func restart_clock(_param1 = 1, _param2 = 2):
	$AnimationPlayer.play("ClockReset")
	seconds_elapsed = 0
	timer_running = false

func resume_clock():
	timer_running = true

func stop_clock():
	timer_running = false


func update_display(value : float):
	var seconds : float
	var minutes : float 
	var hours : float

	seconds = fmod(value, 60.0)
	minutes = floori(value/60.0) % 60
	hours = floori(floori(value/60.0)/60.0)

	text = "%02d:%02d:%06.3f" % [hours, minutes, seconds]
