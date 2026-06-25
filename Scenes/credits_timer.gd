extends Timer

func _ready() -> void:
	timeout.connect(_change_scene)

func _change_scene() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")
