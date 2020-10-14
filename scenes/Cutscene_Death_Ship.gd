extends Spatial

func _ready():
	$transition.play_backwards("transition")
	
func shFall():
	$AnimationPlayer.play("shipFall")
	$ShipVoxel/Particles.emitting = true
	$ShipVoxel/Particles2.emitting = true


func _on_AnimationPlayer_animation_finished(anim_name):
	$ShipVoxel/Particles.emitting = false
	$ShipVoxel/Particles2.emitting = false
	$AudioStreamPlayer.playing = false
	
	$transition.play("transition")
	$Timer.start()


func _on_transition_animation_finished(anim_name):
	shFall()


func _on_Timer_timeout():
	get_tree().change_scene(Globals.stage_2)
