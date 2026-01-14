extends Node

signal play
signal level_selected(level: int)
signal load_level(level: int)

signal level_complete(level: int)

## Gameplay: Switch between the blue and gold states.
signal switch_to(state: int)

signal gameui_fadein_start()
signal gameui_fadein_end()
signal gameui_fadeout_start()
signal gameui_fadeout_end()