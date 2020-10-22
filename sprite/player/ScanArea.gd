extends Area2D

var resSpeed = 600
var damage = preload("res://scenes/DamageCounter.tscn").instance()

func _ready():
	pass
	
func _physics_process(delta):
	position += transform.x * resSpeed * delta

func _on_ScanArea_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
		
	if body.is_in_group("enemies") or body.is_in_group("neutral") or body.is_in_group("pinkofly"):
		body.researchLimit -= 1
		body.add_child(damage)
		
		if body.researchLimit != 1:
			Globals.researchPoint += 1
			body.queue_free()
		queue_free()
	if body.is_in_group("boss"):
		body.health -= 1
		body.add_child(damage)
		print(body.health)
		
		if body.health < 0 or body.health == 0 or body.health <= 0:
			body.health = 0
			Globals.kingPoint += 1
			Globals.bossHealth = body.health
			
			body.queue_free()
			queue_free()
		queue_free()
	if body.name == "Player" or body.name == "Ship":
		#print("cant research yourself") # dont knwo but i had to add this to make it work? 
		return
			
	
	else:
		queue_free()
