extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -250.0
@onready var sprite = $AnimatedSprite2D
var facing_right = false
var is_jumping = false


func _physics_process(delta: float) -> void:
	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	# Flip sprite based on direction
	if direction > 0:
		sprite.flip_h = true    # face right
		facing_right = true
	elif direction < 0:
		sprite.flip_h = false   # face left
		facing_right = false

	# Jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0: 
			is_jumping=true
	# Reset jump when landing
	if is_on_floor() and is_jumping:
		is_jumping = false

	# Animation logic — **only one place**
	if is_jumping:
		sprite.play("jump")
	elif direction != 0:
		sprite.play("walk_left")   # walking animation
	else:
		sprite.play("idle")

	# Apply movement
	move_and_slide()
