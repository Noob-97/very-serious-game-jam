extends Node2D

@export var rotation_speed: float = 60.0

@export_enum("Clockwise:1", "Counter-Clockwise:-1") var spin_direction: int = 1

func _physics_process(delta: float) -> void:
	rotate(deg_to_rad(rotation_speed) * delta)
