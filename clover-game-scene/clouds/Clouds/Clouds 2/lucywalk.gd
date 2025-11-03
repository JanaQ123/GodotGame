extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -275.0

@onready var sprite = $AnimatedSprite2D
var facing_right = false
var is_jumping = false
var health: int = 100  # Player's health

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

	# Apply movement
	move_and_slide()


# 🧱 Damage Function
func take_damage(amount: int) -> void:
	health -= amount
	print("Player took ", amount, " damage! Health: ", health)

	if health <= 0:
		die()


# 💀 Optional: What happens when health reaches zero
func die() -> void:
	print("Player died!")
	queue_free()  # remove player from scene (you can replace with respawn later)
