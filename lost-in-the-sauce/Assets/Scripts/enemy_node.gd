extends Node2D

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var sprite : AnimatedSprite2D = $Path2D/PathFollow2D/AnimatedSprite2D


var player
var checkpoint_manager
var path_ended = false

# speed in px/sec
@export var speed = 100

func _ready():
	#Find player and checkpoint manager
	player = get_tree().get_first_node_in_group("player")
	checkpoint_manager = get_tree().get_first_node_in_group("checkpoint_manager")	
	
	if not player or not checkpoint_manager:
		print("Error: Couldn't find player/checkpoint manager in enemy_node.gd")
		
	show()
	sprite.animation = "roll"
	sprite.play()

func _process(delta: float) -> void:
	path_follow.progress += speed * delta
	if path_follow.progress_ratio == 0.5:
		if path_ended == false:
			sprite.animation = "roll"
			path_ended = true
		else:
			sprite.animation = "rollReverse"
			path_ended = false

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	hide()

#Used to detect player collision
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player touched enemy, killing")
		if checkpoint_manager and player:
			player.position = checkpoint_manager.lastLocation
