extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@onready var sprite = $AnimatedSprite2D

var facing_right := true
var is_jumping := false

# Knockback vars
var knockback_velocity := Vector2.ZERO
var knockback_time := 0.0
var can_move=true
var freefall=false;

func take_knockback(direction: Vector2, force: float):
	knockback_velocity = direction * force
	knockback_time = 0.25  # ¼ second stun duration

func disable_control():
	can_move = false
	velocity = Vector2.ZERO
	sprite.play("idle")

func free_fall():
	freefall=true
	$CollisionShape2D.set_deferred("disabled", true)  # remove support
	velocity.y += 50

	
func _physics_process(delta: float) -> void:
	# 1. Knockback
	if knockback_time > 0:
		velocity = knockback_velocity
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 3000 * delta)
		knockback_time -= delta
		move_and_slide()
		return

	# 2. Freefall (slow-motion)
	if freefall:
		# Optional horizontal control during freefall
		#velocity.x = direction * SPEED * 0.5  # half speed for floaty feel
		velocity.y += 700 * delta  # slow-motion gravity
		move_and_slide()
		return

	# 3. Normal movement
	if can_move:
		var direction := Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED

		# Flip sprite
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
			elif is_jumping and is_on_floor():
				is_jumping = false

		# Animation
		if is_jumping:
			sprite.play("jump")
		elif direction != 0:
			sprite.play("walk_left")
		else:
			sprite.play("idle")

		move_and_slide()
