extends Control


func _on_BackButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene("res://scenes/MainMenu.tscn")
