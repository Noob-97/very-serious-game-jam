extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@export var lives : Array[TextureRect]
@export var timer_text : Label
@export var timer : Timer
var life = 35
var shieldbroken = false
var layer = 1

@export var popups : Array[PackedScene]
@export var popup_timer : Timer
var duck_popup = load("res://Scenes/Popups/POPsta6.tscn")
var idiot_popup = load("res://Scenes/Popups/POPidiot.tscn")
@onready var popup_parent = $Popups

var invincible_timer: float = 0.0

func _ready() -> void:
	floor_snap_length = 5.0
	floor_max_angle = deg_to_rad(60.0)

func _physics_process(delta: float) -> void:
	timer_text.text = str(int(timer.time_left / 60)) + ":" + str(int(timer.time_left) % 60)
	
	if invincible_timer > 0:
		invincible_timer -= delta
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("JumpKey") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("LeftKey", "RightKey")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# KILL
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Check if we hit the static body
		if collider is StaticBody2D:
			if collider.is_in_group("kill") and invincible_timer <= 0:
				life -= 5
				invincible_timer = 1.0
				
				lives[life / 5].visible = false
					
				if life <= 0:
					get_tree().change_scene_to_file("res://DeathScreen.tscn")
			
			# SHIELD
			if collider.is_in_group("shield"):
				collider.hit()
				if collider.shield_life == 0:
					layer += 1
					shieldbroken = true
					collider.OPENER.queue_free()
					collider.queue_free()
					
					if layer >= 3:
						popup_timer.start()

func generate_popup():
	if popup_parent.get_child_count() < 6:
		var random = randi_range(0, popups.size() - 1)
		var scene = popups[random].instantiate()
		popup_parent.add_child(scene)
		if random != 10:
			scene.scale *= 12
			var posx = randf_range(-2750, 1000)
			var posy = randf_range(-1000, 1000)
			scene.position = Vector2(posx, posy)
		else:
			scene.scale *= 5
			scene.position = Vector2(-2900, -1750)


func _escaped(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/EndingError.tscn")

func this_player_is_an_idiot():
	for i in 6:
		var scene = idiot_popup.instantiate()
		popup_parent.add_child(scene)
		scene.scale *= 5
		scene.position = Vector2(-2900, -1750)

func i_love_ducks():
	for i in 10:
		var scene = duck_popup.instantiate()
		popup_parent.add_child(scene)
		scene.scale *= 12
		var posx = randf_range(-2750, 1000)
		var posy = randf_range(-1000, 1000)
		scene.position = Vector2(posx, posy)

func _on_popup_timer_end() -> void:
	generate_popup()
	popup_timer.start()
