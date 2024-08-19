extends Node2D

onready var mapTile = $MapGround/Ground
onready var playerView = $Actors/Player/Camera2D

func _ready():
	set_camera_limits()

func set_camera_limits():
	var map_limits = mapTile.get_used_rect()
	var map_cellsize = mapTile.cell_size
	playerView.limit_left = map_limits.position.x * map_cellsize.x
	playerView.limit_right = map_limits.end.x * map_cellsize.x
	playerView.limit_top = map_limits.position.y * map_cellsize.y
	playerView.limit_bottom = map_limits.end.y * map_cellsize.y
