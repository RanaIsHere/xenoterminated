extends Control

export (PackedScene) var resMenu = preload("res://GUI/ResearchMenu.tscn")

func _ready():
	get_tree().paused = true
	Input.set_mouse_mode(!Input.MOUSE_MODE_CAPTURED)


func _on_Resume_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().paused = false
			self.queue_free()


func _on_Exit_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().paused = false
			self.queue_free()
			
			get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Resume_mouse_entered():
	$MainPanel/Resume.modulate = Color(0.9, 0.9, 1)


func _on_Resume_mouse_exited():
	$MainPanel/Resume.modulate = Color(1, 1, 1)


func _on_Exit_mouse_entered():
	$MainPanel/Exit.modulate = Color(0.9, 0.9, 1)


func _on_Exit_mouse_exited():
	$MainPanel/Exit.modulate = Color(1, 1, 1)


func _on_Research_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var r = resMenu.instance()
			
			add_child(r)
