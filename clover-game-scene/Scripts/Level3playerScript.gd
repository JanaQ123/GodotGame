extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var sprite = $AnimatedSprite2D

var facing_right := true
var is_jumping := false

# Knockback vars
var knockback_velocity := Vector2.ZERO
var knockback_time := 0.0
var can_move=true
var freefall=false;
var powerup=false;
var on_wall=false;
var wall_dir=0;


func _ready() -> void:
	$rainbowparent.visible = false   

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
	velocity.y += 2

func power_up():
	powerup=true
	$rainbowparent.visible = true
	$rainbowparent/AnimationPlayer.play("rainbowgrow")
	#if(is_jumping): velocity.y -= 500
	await get_tree().create_timer(1.5).timeout
	$rainbowparent.visible = false
	powerup=false


	
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
		velocity.y += 100 * delta  # slow-motion gravity
		if self.global_position.y>1100:
			can_move=true
			freefall=false
			$CollisionShape2D.set_deferred("disabled", false)  

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
			if powerup:
				velocity.y = JUMP_VELOCITY * 1.8

			else:
				velocity.y = JUMP_VELOCITY
				is_jumping = true

		# Gravity
		if not is_on_floor():
			velocity += get_gravity() * delta
			if velocity.y < 0:
				is_jumping = true
			else:
				is_jumping = false

			if not powerup:
				if velocity.y < 0:
					is_jumping = true
				elif is_jumping and is_on_floor():
					is_jumping = false


		# Animation
		if not is_on_floor():
			if velocity.y > 400:
				sprite.play("falling")
			else:
				sprite.play("jump")
				
				
		elif direction != 0:
			sprite.play("walk_left")
		else:
			sprite.play("idle")

		move_and_slide()
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider().is_in_group("wall"):
				on_wall = true
				break

	# Simple wall interaction
		#if on_wall:
			#velocity.y = min(velocity.y, 200)

	# Jump
		if on_wall:
			if Input.is_action_just_pressed("ui_accept"):
				velocity.x = wall_dir * 300
				velocity.y = -300
		
