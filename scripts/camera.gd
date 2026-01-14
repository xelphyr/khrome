extends Camera3D


func _ready() -> void:
	EventBus.switch_to.connect(change_mesh_filter)

func change_mesh_filter(to: int) -> void:
	print(to, "cam")
	set_cull_mask_value(2, to==2)
	set_cull_mask_value(1, to==1)
