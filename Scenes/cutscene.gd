extends Control

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var riser: AudioStreamPlayer = $AudioStreamPlayer2
@onready var anim: AnimationPlayer = $AnimationPlayer
@export var dialogue_active: bool
var delay_reset = 0.1
var delay = 0.0

func _ready() -> void:
	# Connect the video player's built-in 'finished' signal to your function
	video_player.finished.connect(_change_scene)
	anim.play("dialogue_flag0")

func _change_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func _process(delta: float) -> void:
	if delay <= 0 and dialogue_active:
		audio_player.play()
		delay = delay_reset
	delay -= delta
	
func play_riser() -> void:
	riser.play()
