extends Control

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var anim: AnimationPlayer = $AnimationPlayer
@export var dialogue_active: bool
@onready var riser: AudioStreamPlayer = $AudioStreamPlayer2

var delay_reset = 0.1
var delay = 0.0

func _ready() -> void:
	anim.play("dialogue_flag2")

func _process(delta: float) -> void:
	if delay <= 0 and dialogue_active:
		audio_player.play()
		delay = delay_reset
	delay -= delta

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed('Restart'):
		get_tree().change_scene_to_file("res://Scenes/Testing/test3.tscn")
		
func play_riser() -> void:
	riser.play()
