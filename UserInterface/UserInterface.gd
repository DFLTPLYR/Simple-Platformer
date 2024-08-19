extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("Label")

const MESSAGE: ="Amogus"

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	update_interface()

func _PlayerData_player_died():
	self.paused = true
	pause_title.text = MESSAGE
	

func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("paused") and pause_title.text != MESSAGE:
			self.paused = not paused
			scene_tree.set_input_as_handled()

func update_interface():
	score.text = "Score: %s" % PlayerData.score

func set_paused(value: bool):
	paused = value
	scene_tree.paused = value
	paused_overlay.visible = value
