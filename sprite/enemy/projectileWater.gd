extends Area2D

var projectileSpeed = 400

func _ready():
	pass

func _physics_process(delta):
	position += transform.x * projectileSpeed * delta



func _on_projectileWater_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.name == "Player":
		queue_free()
		
		Globals.playerHealth -= 5
