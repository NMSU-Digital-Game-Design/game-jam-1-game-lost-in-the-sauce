extends CanvasLayer


func _on_start_pressed() -> void:
	pass # Replace with function body.


func _on_leader_board_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/LeaderBoard.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/CreditMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
