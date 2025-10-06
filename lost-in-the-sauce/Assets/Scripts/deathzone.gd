extends Area2D

# variables
var checkpoint_manager
var player

signal kill_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# gets the node and attaches it to this varaible. same for player
	checkpoint_manager = get_parent().get_node("checkpoint_manager")
	# also, depends on file structure. early errors were thrown because the node is a child
	# of the TileMap
	# this may change depending on how the structure is for the initial 2d map. 
	player = get_parent().get_node("TileMap/Cat")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# this is for the death zone. sends like a beacon or whatever when the player enters the node
# when implementing on the map, use a collision2d node as a child of the deathzone node
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		killPlayer()
		
# basically the bread and butter. returns the player to last location. this be where the initial spawn
# is if we're just starting the game or the location of the respawn point established in 
# checkpoint.
# may be able to work when implementing this for the monsters as well but will require further testing
# and method of how they interact with the player character
func killPlayer():
	player.position = checkpoint_manager.lastLocation
	emit_signal("kill_player")
