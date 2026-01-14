extends Control


@onready var button_grid = $"PanelContainer/MarginContainer/VBoxContainer/ButtonGrid"
var level_select_buttons : ButtonGroup = ButtonGroup.new()

func _ready() -> void:
	for button in button_grid.get_children():
		button.button_group = level_select_buttons
	level_select_buttons.pressed.connect(_level_selected)

func _level_selected(button: BaseButton):
	print("level selected: ", button.name)
	EventBus.level_selected.emit(button.name.to_int())
	get_parent().call("change_state", Enum.UIState.GAME)
