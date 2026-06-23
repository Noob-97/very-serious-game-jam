extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@export var lives : Array[TextureRect]
@export var timer_text : Label
@export var timer : Timer
var life = 35
var shieldbroken = false

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
					shieldbroken = true
					collider.OPENER.queue_free()
					collider.queue_free()
				
	


func _escaped(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/EndingError.tscn")
