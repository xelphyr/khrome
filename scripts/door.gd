extends StaticBody3D
class_name Door

@export var code : int = 0
var color_array : Array[Material] = [

]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CodeIndicator.material_override = color_array[code]	
	EventBus.unlocked.connect(_check_unlocked)
	


func _check_unlocked(key_code : int) -> void:
	if key_code == code:
		unlock()

func unlock():
	$CollisionShape3D.disabled = true
	visible = false