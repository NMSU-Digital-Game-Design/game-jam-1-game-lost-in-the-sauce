extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var speed = 200
var jump_force = -400
var gravity = 900

var current_anim: String = "idle"
var attacking = false  # track if attack is in progress

func _ready():
	anim.animation_finished.connect(_on_anim_finished)

func _on_anim_finished():
	# Reset attack animation
	if attacking:
		attacking = false
		current_anim = ""  # allow other animations

func _physics_process(delta):
	var moving = false

	# --- HORIZONTAL MOVEMENT ---
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		anim.flip_h = true
		moving = true
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
		anim.flip_h = false
		moving = true

	# --- JUMPING ---
	if is_on_floor() and Input.is_action_just_pressed("move_up"):
		velocity.y = jump_force

	# --- GRAVITY ---
	velocity.y += gravity * delta

	# --- MOVE CHARACTER ---
	move_and_slide()

	# --- ANIMATION LOGIC ---
	var new_anim = current_anim

	if attacking:
		# Keep attack animation until finished
		return

	# Attack (Space)
	if Input.is_action_just_pressed("attack"):
		new_anim = "attack"
		attacking = true

	# Jump while in air
	elif not is_on_floor():
		new_anim = "jump"

	# Run if moving left/right
	elif moving:
		new_anim = "run"

	# Sleep while holding down arrow
	elif Input.is_action_pressed("sleep") and is_on_floor() and not moving:
		new_anim = "sleep"

	# Idle
	else:
		new_anim = "idle"

	# Play animation only if it changed
	if new_anim != current_anim:
		anim.play(new_anim)
		current_anim = new_anim


func _on_goal_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
