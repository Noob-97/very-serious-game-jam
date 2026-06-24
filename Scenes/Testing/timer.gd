extends Timer

const NEXT_SCENE_PATH = "res://DeathScreen.tscn"

func _ready() -> void:
	timeout.connect(_change_scene)

func _change_scene() -> void:
	get_tree().change_scene_to_file(NEXT_SCENE_PATH)
