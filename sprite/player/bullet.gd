extends Area2D

var bulletSpeed = 600

var explode = preload("res://DeathExplosion.tscn")
var damage = preload("res://scenes/DamageCounter.tscn").instance()

func _ready():
	pass


func _physics_process(delta):
	position += transform.x * bulletSpeed * delta


func _on_bullet_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.is_in_group("enemies") or body.is_in_group("pinkofly"):
		body.health -= 1
		queue_free()
		if body.get_node_or_null("AudioStreamPlayer"):
			body.get_node("AudioStreamPlayer").playing = true
		if body.health == 0 or body.health < 0:
			Globals.soldierPoint += 1
			body.queue_free()
			
	if body.is_in_group("boss"):
		body.health -= 1
		print(body.health)
		
		body.add_child(damage)
		
		queue_free()
		
		if body.health == 0 or body.health < 0 or body.health <= 0:
			Globals.kingPoint += 1
			body.health = 0
			Globals.bossHealth = body.health
			#
			#get_tree().change_scene("res://scenes/MoveBetweenScene.tscn")
			#
			queue_free()
			body.queue_free()
			
