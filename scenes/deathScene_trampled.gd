extends Spatial

func _ready():
	death()

func death():
	$AnimationPlayer.play_backwards("transTrans")
	
	#yield(get_tree().create_timer(1), "timeout")
	$Timer.start()


func _on_Timer_timeout():
	$RigidBody.linear_velocity = Vector3(25, 0 , 0)
	$p/AudioStreamPlayer3D.playing = true
	
	$AnimationPlayer.play("transTrans")
	
	yield($AnimationPlayer, "animation_finished")
	
	get_tree().change_scene(Globals.currentStage)
