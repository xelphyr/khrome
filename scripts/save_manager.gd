## Singleton responsible for saving and loading gamedata. Usually doesn't interface with any node other than ProgressManager
extends Node 

func load_data() -> Dictionary[StringName, LevelProgressData]:
    return {}

func save_data(data: Dictionary[StringName, LevelProgressData]):
    pass

func clear_save_data():
    pass
