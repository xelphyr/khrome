## Singleton responsible for storing the current session's data, and saving and loading from the SaveManager.
extends Node
const save_disabled : bool = true

var progress_data : Dictionary[StringName, LevelProgressData] = {}
var save_tampered : bool = false

func _ready() -> void:
	call_deferred("load_data") 
	EventBus.progress_level_completed.connect(level_completed)
	EventBus.progress_level_speedran.connect(level_speedran)
	EventBus.progress_level_unlocked.connect(level_unlocked)
	

func load_data():
	progress_data = SaveManager.load_data()
	if progress_data.size() == 0:
		_init_data()

func _init_data():
	print("Initializing Data")
	var uuids = get_tree().get_first_node_in_group(&"LevelManager").request_uuids()
	for uuid_idx in range(uuids.size()):
		if uuid_idx != 0:
			progress_data[uuids[uuid_idx]] = LevelProgressData.new()
		else:
			progress_data[uuids[uuid_idx]] = LevelProgressData.new()
			progress_data[uuids[uuid_idx]].level_unlocked = true

func save_data():
	SaveManager.save_data(progress_data)

func check_level_completed(uuid : StringName) -> bool: 
	if progress_data.has(uuid):
		return progress_data[uuid].level_completed
	else:
		assert(false, "someting very terrible happened: " + uuid)
		return false

func check_level_unlocked(uuid : StringName) -> bool:   
	if progress_data.has(uuid):
		return progress_data[uuid].level_unlocked
	else:
		assert(false, "someting very terrible happened: " + uuid)
		return false

func check_level_speedran(uuid : StringName) -> bool:
	if progress_data.has(uuid):
		return progress_data[uuid].level_speedran
	else:
		assert(false, "someting very terrible happened: " + uuid)
		return false


func level_completed(uuid : StringName): 
	if progress_data.has(uuid):
		progress_data[uuid].level_completed = true
	else:
		assert(false, "someting very terrible happened: " + uuid)

func level_unlocked(uuid : StringName):
	if progress_data.has(uuid):
		progress_data[uuid].level_unlocked = true
	else:
		assert(false, "someting very terrible happened: " + uuid)

func level_speedran(uuid : StringName):
	if progress_data.has(uuid):
		progress_data[uuid].level_speedran = true
	else:
		assert(false, "someting very terrible happened: " + uuid)
