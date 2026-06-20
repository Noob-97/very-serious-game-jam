extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@export var text: Label
var life = 5

var invincible_timer: float = 0.0

func _ready() -> void:
	floor_snap_length = 5.0
	floor_max_angle = deg_to_rad(60.0)
	if text:
		text.text = "LIFE: " + str(life)

func _physics_process(delta: float) -> void:
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
				
				if text:
					text.text = "LIFE: " + str(life)
					
				if life <= 0:
					get_tree().reload_current_scene()
	
