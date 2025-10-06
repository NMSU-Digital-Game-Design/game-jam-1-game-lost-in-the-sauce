extends Node2D

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var sprite : AnimatedSprite2D = $Path2D/PathFollow2D/AnimatedSprite2D
var path_ended = false

# speed in px/sec
@export var speed = 100

func _ready():
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
