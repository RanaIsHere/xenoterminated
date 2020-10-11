extends KinematicBody2D

var enemySpeed = 80

export var health = 1

func _ready():
	set_physics_process(false)
	set_process(false)

func _physics_process(delta):
	if Globals.approachedBodies.size() > 0:
		look_at(Globals.approachedBodies[0].position)
		
		position += transform.x * enemySpeed * delta

func _process(delta):
	Globals.playerHealth -= 0.5

func _on_detectionRadius_body_entered(body):
	if body.name == "Player":
		set_physics_process(true)
		Globals.approachedBodies.append(body)


#func _on_detectionRadius_body_exited(body):
#	if body.name == "Player":
#		set_physics_process(false)
#		Globals.approachedBodies.remove(Globals.approachedBodies.find(body))


func _on_Hobrun_body_entered(body):
	if body.name == "Player":
		set_process(true)


func _on_Hobrun_body_exited(body):
	if body.name == "Player":
		set_process(false)
