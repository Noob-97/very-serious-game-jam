extends Control

@export_enum("Regular:0", "DUCK:1", "DVD:2", "IDIOT:3") var Type : int = 0

var parent
var texture
var speed = 200
var velocity
var invert = false

func _ready() -> void:
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if Type == 2:
		parent = get_node("..")
	if Type == 3:
		parent = get_node("..")
		texture = find_child("popup")
		speed = 600

func _physics_process(delta: float) -> void:
	if Type == 2 or Type == 3:
		position += velocity * speed * delta

		var current_size: Vector2 = size
		var max_bounds: Vector2 = parent.size
		
		if position.x <= 0:
			position.x = 0
			velocity.x = -velocity.x 
			change_color()
		elif position.x + current_size.x >= max_bounds.x:
			position.x = max_bounds.x - current_size.x
			velocity.x = -velocity.x
			change_color()
			
		if position.y <= 0:
			position.y = 0
			velocity.y = -velocity.y
			change_color()
		elif position.y + current_size.y >= max_bounds.y:
			position.y = max_bounds.y - current_size.y
			velocity.y = -velocity.y
			change_color()

func change_color():
	if Type == 2:
		var random = randi_range(0, 6)
		match random:
			0:
				modulate = Color.MAGENTA
			1:
				modulate = Color.CYAN
			2:
				modulate = Color.YELLOW
			3:
				modulate = Color.GREEN
			4:
				modulate = Color.ORANGE
			5:
				modulate = Color.PURPLE
			6:
				modulate = Color.RED
	if Type == 3:
		invert = not invert
		texture.material.set_shader_parameter("invert", invert)

func _on_button_pressed() -> void:
	if Type == 2:
		parent.queue_free()
		return
		
	queue_free()

func _on_interacted():
	if Type == 1:
		get_node("../..").i_love_ducks()
		queue_free()
		return
	if Type == 3:
		get_node("../..").this_player_is_an_idiot()
		parent.queue_free()
		return
	
	get_node("../..").this_player_is_an_idiot()
	queue_free()


func _idiot_finished() -> void:
	parent.queue_free()
