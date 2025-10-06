extends Control

@onready var play_again_button = $TextureRect/VBoxContainer/Button_play_again
@onready var quit_button = $TextureRect/VBoxContainer/Button_quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	play_again_button.text = "Play Again"
	quit_button.text = "Quit"
	process_mode = Node.PROCESS_MODE_ALWAYS #allows to run when paused
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_screen():
	visible = true
	get_tree().paused = true #Freeze game

func _on_button_play_again_pressed() -> void:
	print("pressed play again")
	get_tree().paused = false #unfreeze game
	get_tree().reload_current_scene() #restart

func _on_button_quit_pressed() -> void:
	print("pressed quit")
	get_tree().quit()


func _on_goal_area_player_won() -> void:
	show_screen()
