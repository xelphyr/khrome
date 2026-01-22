extends Label
class_name Clock

var _raw_seconds_elapsed : float
var seconds_elapsed : float :
	get:
		return _raw_seconds_elapsed
	set(value):
		_raw_seconds_elapsed = value
		update_display(value)
		 

var timer_running : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.load_level.connect(start_clock)
	EventBus.level_complete.connect(stop_clock)
	EventBus.level_failed.connect(restart_clock)

func _process(delta: float) -> void:
	if timer_running:
		seconds_elapsed += delta

func start_clock(_param):
	seconds_elapsed = 0
	timer_running = true

func restart_clock():
	seconds_elapsed = 0

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

