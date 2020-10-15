extends KinematicBody2D

var enemySpeed = 80

export var health = 1

export var researchLimit = 1

var colliders

func _ready():
	set_physics_process(false)
	set_process(false)
	$AnimationPlayer.play("opacityBlink")
	colliders = null

func _physics_process(delta):
	#if Globals.approachedBodies.size() > 0:
		#look_at(Globals.approachedBodies[0].position)
	if colliders != null:
		look_at(colliders.position)
		
		position += transform.x * enemySpeed * delta

func _process(_delta):
	Globals.playerHealth -= 0.5

func _on_detectionRadius_body_entered(body):
	if body.name == "Player":
		set_physics_process(true)
		colliders = body
		$AudioStreamPlayer2D.playing = true

func _on_Hobrun_body_entered(body):
	if body.name == "Player":
		Globals.deathType = "trampled"
		set_process(true)


func _on_Hobrun_body_exited(body):
	if body.name == "Player":
		Globals.deathType = null
		set_process(false)
