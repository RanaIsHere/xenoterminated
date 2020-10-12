extends KinematicBody2D

export var timeLoop : float = 0.0
export var timeMax : float = 10.0 # First

export var timeLoop2 : float = 0.0
export var timeMax2 : float = 10.0 # Pong Second

export var health = 2

func _ready():
	set_process(false)
	
func _process(_delta):
	Globals.playerHealth -= 0.1
	
func _physics_process(delta):
	if timeLoop < timeMax:
		timeLoop += delta
	if timeLoop > timeMax:
		position += transform.y * -50 * delta
		if timeLoop2 < timeMax2:
			timeLoop2 += delta
		if timeLoop2 > timeMax2:
			timeLoop2 = 0.0
			timeLoop = 0.0
		
	else:
		position += transform.y * 50 * delta

func _on_radius_body_entered(body):
	if body.name == "Player":
		set_process(true)
		$radius/AudioStreamPlayer2D.playing = true
		Globals.deathType = "trampled"
		
func _on_radius_body_exited(body):
	if body.name == "Player":
		set_process(false)
		$radius/AudioStreamPlayer2D.playing = false
