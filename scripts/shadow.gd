extends Decal
class_name Shadow

@export var shadow_dist : float = 9999
var collision_mask : int = 0x0001

func _ready() -> void:
	EventBus.switch_to.connect(func(to:int):
		collision_mask = pow(2, to-1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var parent_pos = get_parent().position
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(parent_pos, parent_pos + Vector3.DOWN * shadow_dist, collision_mask, [self])
	var result = space_state.intersect_ray(query)
	if result.size() == 0:
		visible = false
	else:
		visible = true
		global_position = result.position
