extends Control

func _ready():
	$AnimationPlayer.play("SceneFlash")


func _on_AudioStreamPlayer_finished():
	queue_free()
