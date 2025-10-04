extends Node

var lastLocation
var player

# just manages where the last location the player was. updates it and all
func _ready() -> void:
	player = get_parent().get_node("TileMap/player")
	lastLocation = player.global_position
