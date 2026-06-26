extends Control

@export var popups : Array[PackedScene]

func _ready() -> void:
	var random = randi_range(0, popups.size() - 1)
	var scene = popups[random].instantiate()
	add_child(scene)
	scene.scale *= 4
	scene.position = Vector2(50, 50)

func start():
	get_tree().change_scene_to_file("res://Controls.tscn")

func exit():
	get_tree().quit()
