extends Control

func _ready() -> void:
	get_node("AnimationPlayer").play("credits_fadeout")

func back():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
