extends StaticBody3D
class_name Door

@export var code : int = 0
var color_array : Array[Material] = [
	preload("uid://b4kndl2iuq5vv"),
	preload("uid://clfocv5uo5ucq"),
	preload("uid://dulsdkjc2vcrs"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DoorMesh.material_override = color_array[code]	
	EventBus.unlocked.connect(_check_unlocked)
	


func _check_unlocked(key_code : int) -> void:
	if key_code == code:
		unlock()

func unlock():
	AudioManager.create_audio(SoundEffectSettings.SoundEffectType.DOOR_OPEN)
	$AnimationPlayer.play("DoorLower")
