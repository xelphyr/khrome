extends Area3D
class_name Key

@export var code : int = 0
var color_array : Array[Material] = [

]

func _ready() -> void:
	$CodeIndicator.material_override = color_array[code]	


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"Player"):
		EventBus.unlocked.emit(code)
