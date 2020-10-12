extends Area2D


func _ready():
	pass
	


func _on_ScanArea_body_entered(body):
	if body.is_in_group("enemies") or body.is_in_group("neutral"):
		queue_free()
		body.queue_free()
		Globals.researchPoint += 1
	if body.is_in_group("boss"):
		queue_free()
		body.health -= 1
		
		if body.health < 0 or body.health == 0 or body.health <= 0:
			body.health = 0
			Globals.kingPoint += 1
			body.queue_free()
			Globals.bossHealth = body.health
			
			queue_free()
			
			
	
	else:
		queue_free()
