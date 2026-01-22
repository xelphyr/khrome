extends RichTextLabel
class_name TypewriterLabel

@export var max_characters : int
#@export var full_text : String
@export var char_delay : float = 0.2
#@export var cursor : String = "|"
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = char_delay 
	timer.one_shot = false
	timer.timeout.connect(increment_visible_letter)

	add_child(timer)

	visible_characters = 0


func start_display(new_text: String):
	print("starting dislay for", name)
	visible_characters = 0
	if new_text:
		text = new_text
	timer.start()
	
func increment_visible_letter():
	visible_characters += 1
	if visible_characters >= max_characters:        
		timer.stop()
		

func reset_display():
	timer.stop()
	text = ""
	visible_characters = 0
