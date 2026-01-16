extends StaticBody3D

@export var positions : Array[Node3D] = []
@export var lerp_curve : Curve
@export var lerp_time : float = 5
@export var wait_time : float = 2

enum State {MOVE, WAIT}
var curr_state : State

var curr_idx = 0

var _cooldown : float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = positions[0].position


func _process(delta: float) -> void:
	match curr_state:
		State.MOVE:
			position = positions[curr_idx].position.lerp(
				positions[_next_idx()].position, 
				lerp_curve.sample( _cooldown/lerp_time)
			)
			_cooldown += delta
			if _cooldown >= lerp_time:
				position = positions[_next_idx()].position
				_cooldown -= lerp_time
				curr_state = State.WAIT
		State.WAIT:
			_cooldown += delta
			if _cooldown >= wait_time:
				_cooldown -= wait_time
				curr_idx = _next_idx()
				curr_state = State.MOVE

func _next_idx() -> int:
	return (curr_idx + 1) % positions.size()
