extends CanvasLayer




func _ready():
	load_name_entries("res://data.json")


func load_name_entries(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		print("Failed file")
		return
	
	var json = JSON.new()
	var result = json.parse(file.get_as_text())
	if result != OK:
		print("JSON parse error: ", result)
		return
	
	var data = json.data
	
	if data.has("players"):
		for player in data["players"]:
			var label_text = str(player["name"]) + " - " + str(player["time"])
			create_player_label_text(label_text)

func create_player_label_text(text: String):
	var label = Label.new()
	label.text = text
	$Panel/Panel/VBoxContainer.add_child(label)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/StartMenu.tscn")
