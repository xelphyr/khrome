## Class that is specifically for the data inherent to each level: level name, level UUID, etc.
class_name LevelData
extends Resource 


## Unique ID of the level. Mainly for save data
@export var level_uuid: StringName
## Name of the level. This is what is displayed in the GameUI.
@export var level_name: StringName 
##Scene that relates to this level
@export var scene : PackedScene
## Time to beat on this level in order to unlock the chapter's prologue, in seconds.
@export var speedrun_time: float 

func get_uuid() -> StringName:
    return level_uuid
func get_level_name() -> StringName:
    return level_name
func get_speedrun_time() -> float:
    return speedrun_time
func get_scene() -> PackedScene:
    return scene
