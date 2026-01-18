extends Node

signal play
signal level_selected(level: int)
signal load_level(level: int)

signal level_complete()
signal level_failed()

signal pause_game()
signal resume_game()

signal exit_level()

## Gameplay: Switch between the blue and gold states.
signal switch_to(state: int)

signal gameui_fadein_start()
signal gameui_fadein_end()
signal gameui_fadeout_start()
signal gameui_fadeout_end()