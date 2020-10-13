extends Spatial

func _ready():
	mbs()

func mbs():
	$AnimationPlayer.play("shipMovement")
	$Camera/AnimatedSprite3D/AudioStreamPlayer3D.playing = true
	
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene(Globals.nextStage)
