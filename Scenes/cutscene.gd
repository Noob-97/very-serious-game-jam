extends Control

const NEXT_SCENE_PATH = "res://Scenes/Testing/test3.tscn"

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer

func _ready() -> void:
	# Connect the video player's built-in 'finished' signal to your function
	video_player.finished.connect(_change_scene)

func _change_scene() -> void:
	get_tree().change_scene_to_file(NEXT_SCENE_PATH)
