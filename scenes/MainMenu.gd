extends Control


func _ready():
	OS.set_window_title("Xenoterminated - Main Menu")
	_wait()

func _wait():
	yield(get_tree().create_timer(1), "timeout")
	
	$AnimationPlayer.play("transition")
	OS.window_maximized = true

func _on_Start_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			$AnimationPlayer.play_backwards("transition")
			
			yield($AnimationPlayer, "animation_finished")
			
			get_tree().change_scene("res://scenes/Cutscene_Entrance.tscn")


func _on_Exit_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().quit(0)


func _on_Instruction_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			$Start.visible = false
			$Instruction.visible = false
			$Exit.visible = false
			$Back.visible = true
	
			$InstructionText.visible = true


func _on_Back_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			$Start.visible = true
			$Instruction.visible = true
			$Exit.visible = true
			$Back.visible = false
	
			$InstructionText.visible = false
