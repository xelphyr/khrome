extends RichTextLabel
class_name DialogueLabel

#@export var full_text : String
@export var char_delay : float = 0.05
@export var characters_per_tick : int = 1
@export var decay : float = 2
#@export var cursor : String = "|"
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = char_delay 
	timer.one_shot = false
	timer.autostart = false
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
	visible_characters += characters_per_tick
	if visible_characters >= text.length():        
		timer.timeout.disconnect(increment_visible_letter)
		timer.one_shot = true
		timer.timeout.connect(func(): queue_free())
		timer.stop()
		timer.start(decay)
