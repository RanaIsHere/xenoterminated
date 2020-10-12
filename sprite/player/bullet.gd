extends Area2D

var bulletSpeed = 600

var explode = preload("res://DeathExplosion.tscn")

func _ready():
	pass


func _physics_process(delta):
	position += transform.x * bulletSpeed * delta


func _on_bullet_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.is_in_group("enemies"):
		body.health -= 1
		queue_free()
		
		if body.health == 0 or body.health < 0:
			Globals.soldierPoint += 1
			body.queue_free()
			
	if body.is_in_group("boss"):
		body.health -= 1
		print(body.health)
		queue_free()
		
		if body.health == 0 or body.health < 0 or body.health <= 0:
			Globals.kingPoint += 1
			body.health = 0
			Globals.bossHealth = body.health
			
			get_tree().change_scene("res://scenes/MoveBetweenScene.tscn")
			
			queue_free()
			body.queue_free()
			
