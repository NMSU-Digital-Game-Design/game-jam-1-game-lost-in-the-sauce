extends Area2D

var checkpoint_manager

# Called when the node enters the scene tree for the first time.
# once again, make sure to check how the files are set up and run off that
# when adding more checkpoints, drag the scene checkpoint to the checkpoint_manager 
func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("checkpoint_manager")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# this updates wehre the respawn point will be set at. goes off the instances established in the
# checkpoint scene.
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint_manager.lastLocation = $respawn_point.global_position
