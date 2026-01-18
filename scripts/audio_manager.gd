extends Node3D

@export var sound_effect_settings : Array[SoundEffectSettings] = []
var sound_effect_dict : Dictionary[SoundEffectSettings.SoundEffectType, SoundEffectSettings] = {}

func _ready() -> void:
    for sound_effect_setting : SoundEffectSettings in sound_effect_settings:
        sound_effect_dict[sound_effect_setting.type] = sound_effect_setting

func create_3d_audio_at_location(location : Vector3, type : SoundEffectSettings.SoundEffectType) -> void:
    if sound_effect_dict.has(type):
        var sound_effect_setting : SoundEffectSettings = sound_effect_dict[type]
        if sound_effect_setting.has_open_limit():
            sound_effect_setting.change_audio_count(1)
            var new_3D_audio = AudioStreamPlayer3D.new()
            add_child(new_3D_audio)

            new_3D_audio.position = location
            new_3D_audio.stream = sound_effect_setting.sound_effect
            new_3D_audio.volume_db = sound_effect_setting.vol
            new_3D_audio.pitch_scale = sound_effect_setting.pitch_scale
            new_3D_audio.pitch_scale += randf_range(-sound_effect_setting.pitch_randomness, sound_effect_setting.pitch_randomness)
            new_3D_audio.finished.connect(sound_effect_setting.on_audio_finished)
            new_3D_audio.finished.connect(new_3D_audio.queue_free)

            new_3D_audio.play()
    else:
        push_error("SoundEffectSetting not declared/added to AudioManager for type ", type)

func create_audio(type : SoundEffectSettings.SoundEffectType) -> void:
    if sound_effect_dict.has(type):
        var sound_effect_setting : SoundEffectSettings = sound_effect_dict[type]
        if sound_effect_setting.has_open_limit():
            sound_effect_setting.change_audio_count(1)
            var new_audio = AudioStreamPlayer.new()
            add_child(new_audio)

            new_audio.stream = sound_effect_setting.sound_effect
            new_audio.volume_db = sound_effect_setting.vol
            new_audio.pitch_scale = sound_effect_setting.pitch_scale
            new_audio.pitch_scale += randf_range(-sound_effect_setting.pitch_randomness, sound_effect_setting.pitch_randomness)
            new_audio.finished.connect(sound_effect_setting.on_audio_finished)
            new_audio.finished.connect(new_audio.queue_free)

            new_audio.play()
    else:
        push_error("SoundEffectSetting not declared/added to AudioManager for type ", type)