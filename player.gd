extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@export var text: Label
var life = 100

func _physics_process(delta: float) -> void:
	# KILL
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Check if we hit the static body
		if collider is StaticBody2D:
			if collider.name.contains("kill"):
				life -= 1
				text.text = "LIFE: " + str(life)
				if life <= 0:
					get_tree().reload_current_scene()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
