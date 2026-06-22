extends StaticBody2D

var shield_life = 3
@onready var sprite3 = $"3"
@onready var sprite2 = $"2"
@onready var sprite1 = $"1"
var invincible_timer: float = 0.0

@export var OPENER: Node

func _physics_process(delta: float):
	if invincible_timer > 0:
		invincible_timer -= delta 

func hit():
	if invincible_timer <= 0:
		invincible_timer = 1.0
		shield_life -= 1
		if shield_life == 2:
			sprite3.visible = false
			sprite2.visible = true
		if shield_life == 1:
			sprite2.visible = false
			sprite1.visible = true
