extends Spatial

func _ready():
	death()
	
func death():
	#yield(get_tree().create_timer(5), "timeout")
	$Timer.start()


func _on_Timer_timeout():
	$AnimationPlayer.play("deathTransition")
	
	yield($AnimationPlayer, "animation_finished")
	
	get_tree().change_scene(Globals.currentStage)
