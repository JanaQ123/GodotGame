extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -275.0

@onready var sprite = $AnimatedSprite2D
var facing_right = false
var is_jumping = false
var health: int = 100  # Player's health
var on_wall=false
var wall_dir=0;

func _ready():
	Engine.time_scale=1
	
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

	on_wall=false
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("rainbow") and not is_on_floor():
			on_wall = true
			wall_dir = -sign(collision.get_normal().x)

	if on_wall:
		velocity.y = min(velocity.y, 100)
		if Input.is_action_just_pressed("ui_accept") :
			velocity.y = min(velocity.y, 100)
			velocity.x = wall_dir * 300
			velocity.y = -350

# 🧱 Damage Function
func take_damage(amount: int) -> void:
	health -= amount

	if health <= 0:
		die()


# 💀 Optional: What happens when health reaches zero
func die() -> void:
	queue_free()  # remove player from scene (you can replace with respawn later)
