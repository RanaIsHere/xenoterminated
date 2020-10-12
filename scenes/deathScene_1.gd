extends Spatial


func _ready():
	death()
	
func death():
	#yield(get_tree().create_timer(2), "timeout")
	$Timer.start()


func _on_Timer_timeout():
	$Bullet.queue_free()
	$body/head.linear_velocity = Vector3(5, 0 , 0)
	$body/head/AudioStreamPlayer3D.playing = true
	$body/head/CollisionShape.disabled = true
	
	$AnimationPlayer.play("deathTransition_2")
	
	yield($AnimationPlayer, "animation_finished")
	
	get_tree().change_scene(Globals.currentStage)
