extends Node

signal play
signal level_selected(level: int)

## Gameplay: Switch between the blue and gold states.
signal switch_to(state: int)