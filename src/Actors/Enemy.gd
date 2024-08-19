extends "res://src/Actors/Actor.gd"

onready var stomp_area: Area2D = $StompDetector
onready var animate = $AnimatedSprite

export var score: = 100

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	animate.play("Animate")
	
func _on_StompDetector_body_entered(body: Node2D) -> void:
	if body.global_position.y < get_node("StompDetector").global_position.y:
		return
	die()

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity,
	FLOOR_NORMAL).y

func die():
	queue_free()
	PlayerData.score += score
