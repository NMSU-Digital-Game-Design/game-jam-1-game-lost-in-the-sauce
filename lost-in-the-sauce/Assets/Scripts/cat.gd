extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox: Area2D = $AttackHitbox

signal player_lost

var speed = 200
var jump_force = -400
var gravity = 900
var lives = 3 

var current_anim: String = "idle"
var attacking = false  # track if attack is in progress

func _ready():
	anim.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	attack_hitbox.monitoring = false #disable hitbox
	
#func _on_anim_finished():
	## Reset attack animation
	#if attacking and anim.animation == "attack":
		#attacking = false
		#current_anim = ""  # allow other animations

func _physics_process(delta):
	var moving = false

	# --- HORIZONTAL MOVEMENT ---
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		anim.flip_h = true
		attack_hitbox.position.x = -abs(attack_hitbox.position.x)
		moving = true
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
		anim.flip_h = false
		attack_hitbox.position.x =-abs(attack_hitbox.position.x)  
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

	## Keep attack animation until finished
	#if not attacking:
#
	## Attack (Space)
	#if Input.is_action_just_pressed("attack"):
		#new_anim = "attack"
		#attacking = true
		#attack_hitbox.monitoring = true #enable hitbox

	# Jump while in air
	if not is_on_floor():
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


func _on_animated_sprite_2d_animation_finished() -> void:
	# Reset attack animation
	print("anim finished")
	if attacking and anim.animation == "attack":
		print("anim finished, conditions met")
		attacking = false
		current_anim = ""  # allow other animations
		attack_hitbox.monitoring = false 


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free() #KILL 


func _on_meatball_enemy_killed_player() -> void:
	died()
func _on_deathzone_kill_player() -> void:
	died()
	
func died():
	lives -= 1
	
	if lives <= 0:
		emit_signal("player_lost")
		lives = 3
		
