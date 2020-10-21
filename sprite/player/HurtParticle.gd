extends Node2D

func _ready():
	$Particles2D.emitting = true

func _process(delta):
	if $Particles2D.emitting == false:
		queue_free()
