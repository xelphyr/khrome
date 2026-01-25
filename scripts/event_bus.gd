extends Node

signal play
signal level_selected(chapter: int, level: int)
signal load_level(chapter: int, level: int)

signal level_complete()
signal level_failed()

signal pause_game()
signal resume_game()

signal exit_level()

## Signal between doors and keys, others can listen in if they want
signal unlocked(code: int)

## Gameplay: Switch between the blue and gold states.
signal switch_to(state: int)

signal gameui_fadein_start()
signal gameui_fadein_end()
signal gameui_fadeout_start()
signal gameui_fadeout_end()

signal phase_lock_unlock_enter()

signal player_movement_started()

signal progress_level_completed(uuid: StringName)
signal progress_level_unlocked(uuid: StringName)
signal progress_level_speedran(uuid: StringName)