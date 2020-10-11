extends KinematicBody2D

export var timeLoop : float = 0.0
export var timeMax : float = 6.0

export var birdSpeed = -200

export var health = 1

var pos

func _ready():
	pos = position
	
	set_physics_process(true)

func _physics_process(delta):
	if timeLoop < timeMax:
		timeLoop += delta
	if timeLoop > timeMax:
		position = pos
		timeLoop = 0.0
	else:
		position += transform.y * birdSpeed * delta


func _on_areaDetect_body_entered(body):
	if body.name == "Player":
		$AudioStreamPlayer2D.playing = true


func _on_areaDetect_body_exited(body):
	if body.name == "Player":
		$AudioStreamPlayer2D.playing = false
