extends KinematicBody2D

export var health = 1
export var researchLimit = 1

func _ready():
	pass
	
func _physics_process(delta):
	position += transform.y * 380 * delta


func _on_collisionHurt_body_entered(body):
	if body.name == "Ship":
		Globals.playerHealth -= 10
		Globals.deathType = "trampled"
		queue_free()
	if body.is_in_group("invincible"):
		queue_free()

