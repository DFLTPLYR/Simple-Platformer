extends Actor

export var stomp_impulse: = 1600.0

onready var animate = $AnimationPlayer
onready var sprite = $player

func _ready() -> void:
	Engine.target_fps = 60
	animate.play("Idle")

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = false
		animate.play("Run")
	elif Input.is_action_pressed("move_left"):
		sprite.flip_h = true
		animate.play("Run")
	elif Input.is_action_pressed("jump"):
		animate.play("Jump")
	else:
		animate.play("Idle")

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
		)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:

	var calc_velocity: = linear_velocity
	calc_velocity.x = speed.x * direction.x
	calc_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		calc_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		calc_velocity.y = 0.0
	return calc_velocity
	
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die():
	PlayerData.deaths += 1
	queue_free()
