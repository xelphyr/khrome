extends Area3D
class_name Key

@export var code : int = 0
var color_array : Array[Material] = [
	preload("uid://b4kndl2iuq5vv"),
	preload("uid://clfocv5uo5ucq"),
	preload("uid://dulsdkjc2vcrs"),
]

func _ready() -> void:
	$CodeIndicator.material_override = color_array[code]	


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"Player"):
		EventBus.unlocked.emit(code)
		queue_free()
