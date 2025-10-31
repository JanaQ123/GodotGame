extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@onready var sprite = $AnimatedSprite2D

var facing_right := true
var is_jumping := false

# Knockback vars
var knockback_velocity := Vector2.ZERO
var knockback_time := 0.0

func take_knockback(direction: Vector2, force: float):
	knockback_velocity = direction * force
	knockback_time = 0.25  # ¼ second stun duration

func _physics_process(delta: float) -> void:
	# Handle knockback first
	if knockback_time > 0:
		velocity = knockback_velocity
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 3000 * delta)
		knockback_time -= delta
		move_and_slide()
		return  # skip player input during knockback

	# Normal player control
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	# Flip sprite based on direction
	if direction > 0:
		sprite.flip_h = true
		facing_right = true
	elif direction < 0:
		sprite.flip_h = false
		facing_right = false

	# Jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0: 
			is_jumping = true

	# Reset jump when landing
	if is_on_floor() and is_jumping:
		is_jumping = false

	# Animation logic
	if is_jumping:
		sprite.play("jump")
	elif direction != 0:
		sprite.play("walk_left")
	else:
		sprite.play("idle")

	move_and_slide()
