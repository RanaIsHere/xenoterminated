extends Spatial

var oneShot = 0

func _ready():
	OS.set_window_title("Xenoterminated - Arrival")
	$AnimationPlayer.play("Transition")
	_wait()

func _wait():
	yield($AnimationPlayer, "animation_finished")
	
	$CutscenePlayer.play("Cutscene_Entrance")

func _on_CutscenePlayer_animation_finished(anim_name):
	if anim_name == "Cutscene_Entrance":
		$AnimationPlayer.play_backwards("Transition")


func _on_AnimationPlayer_animation_finished(anim_name):
	oneShot += 1
	
	if anim_name == "Transition" and oneShot == 2:
		get_tree().change_scene("res://scenes/world/stage_1.tscn")
