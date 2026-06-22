extends Node2D

var vel = 4
@onready var sprite : Sprite2D = $Sprite2D

# ROTATION FUNCTION
var deg = 0
var rotationslow = 4
var lastdirpositive = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_rotate(delta)
	

func move_and_rotate(delta: float):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += dir * vel
	
	if dir.x > 0:
		deg = 360
		lastdirpositive = true
	if dir.x < 0:
		deg = -360
		lastdirpositive = false
		
	if deg < 180:
		if dir.y > 0:
			deg = 180
			lastdirpositive = true
		if dir.y < 0:
			deg = -180
			lastdirpositive = false
			
	sprite.rotate(delta * deg_to_rad(deg))
	
	if deg != 0:
		if lastdirpositive:
			if deg - rotationslow < 0:
				deg = 0
			else:
				deg -= rotationslow
		else:
			if deg - rotationslow > 0:
				deg = 0
			else:
				deg += rotationslow
	
	if deg == 0 and sprite.rotation_degrees != 0:
		sprite.scale.y = 0.7
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "scale", Vector2(0.5, 0.5), 0.15)
		sprite.rotation_degrees = 0
