tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

# warning-ignore:unused_argument
func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "the next sceen cant be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(next_scene)
