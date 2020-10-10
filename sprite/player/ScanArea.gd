extends Area2D


func _ready():
	pass
	


func _on_ScanArea_body_entered(body):
	if body.is_in_group("enemies") or body.is_in_group("neutral"):
		queue_free()
		body.queue_free()
		Globals.researchPoint += 1
	else:
		queue_free()
