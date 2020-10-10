extends Area2D

var bulletSpeed = 600

func _ready():
	pass


func _physics_process(delta):
	position += transform.x * bulletSpeed * delta


func _on_bullet_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.is_in_group("enemies"):
		body.queue_free()
		queue_free()
		
		Globals.soldierPoint += 1
