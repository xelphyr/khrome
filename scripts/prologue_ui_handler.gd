extends GameUIHandler
class_name PrologueUIHandler

@export var dialog_sets : Array[String] = [
	"res://resources/dialog_sets/prologue_1.json"
]

var dialog
var chapter : int = 1
var curr_dialogue_number : int = 1
var curr_line_number : int = 1

var dialog_timer : Timer

# Called when the node enters the scene tree for the first time.
func setup_other_stuff() -> void:
	dialog = load_dialogue(dialog_sets[chapter-1])
	EventBus.prologue_trigger_dialogue.connect(start_dialogue)

	dialog_timer = Timer.new() 
	dialog_timer.one_shot = true
	dialog_timer.wait_time = 0.05
	dialog_timer.autostart = false
	dialog_timer.timeout.connect(play_dialogue)

	$MarginContainer/VBoxContainer3.add_child(dialog_timer)


func set_level_idx():
	level_idx_display.start_display("PROLOGUE %d" % chapter)

func set_level_name():
	pass

func load_dialogue(path : String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Dialogue file not found: " + dialog_sets[0])
		return {}
	
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	if typeof(result) != TYPE_DICTIONARY:
		push_error("Invalid dialogue JSON")
		return {}

	return result	

func start_dialogue(index : int):
	force_stop()
	curr_dialogue_number = index
	curr_line_number = 1
	get_tree().paused = true
	play_dialogue()

func play_dialogue():
	var line = DialogueLabel.new() 
	var line_data = dialog["dialogues"][curr_dialogue_number-1][curr_line_number-1]
	
	line.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	line.modulate = Color(dialog.speakers[line_data.speaker].color)
	line.fit_content = true
	line.size_flags_horizontal = Control.SIZE_FILL
	line.size_flags_vertical = Control.SIZE_SHRINK_BEGIN

	$MarginContainer/VBoxContainer3.add_child(line) 
	line.start_display(line_data.text)

	if curr_line_number < dialog.dialogues[curr_dialogue_number-1].size():
		curr_line_number += 1
		dialog_timer.start(line_data.delay)
	else:
		get_tree().paused = false


func force_stop():
	dialog_timer.stop()