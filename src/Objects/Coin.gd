extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 100

func _on_body_entered(body: PhysicsBody2D) -> void:
	pick()

func pick():
	PlayerData.score += score
	anim_player.play("fade_out")
