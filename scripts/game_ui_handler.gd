extends Control
class_name GameUIHandler

const fade_time : float = 1
var cooldown : float = 0

enum State {DEFAULT, FADEIN, FADEOUT}
var curr_state = State.DEFAULT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.gameui_fadein_start.connect(func(): curr_state = State.FADEIN)
	EventBus.gameui_fadeout_start.connect(func(): curr_state = State.FADEOUT)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_state == State.FADEIN:
		$Panel.modulate.a = lerpf(0.0, 1.0, cooldown/fade_time)
		cooldown += delta
		if cooldown >= fade_time:
			$Panel.modulate.a = 1.0
			cooldown = 0
			curr_state = State.DEFAULT
			EventBus.gameui_fadein_end.emit()
	if curr_state == State.FADEOUT:
		$Panel.modulate.a = lerpf(1.0, 0.0, cooldown/fade_time)
		cooldown += delta
		if cooldown >= fade_time:
			$Panel.modulate.a = 0.0
			cooldown = 0
			curr_state = State.DEFAULT
			EventBus.gameui_fadeout_end.emit()

