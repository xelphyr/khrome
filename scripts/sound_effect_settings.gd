extends Resource
class_name SoundEffectSettings

enum SoundEffectType {
    JUMP,
    WIN,
    LEVEL_ENTER,
    LASER,
    FALL,
    BUTTON_SELECT
}

@export_range(0,10) var limit : int = 5
@export var type : SoundEffectType
@export var sound_effect : AudioStreamWAV
@export_range(-40, 20) var vol = 0
@export_range(0.0, 4.0, 0.1) var pitch_scale = 1.0
@export_range(0.0, 1.0, 0.1) var pitch_randomness = 0

var audio_count = 0

func change_audio_count(amount: int):
    audio_count = max(0, audio_count + amount)

func has_open_limit() -> bool:
    return audio_count < limit

func on_audio_finished():
    change_audio_count(-1)