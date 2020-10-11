extends Area2D


export var ammunition = 5

func _ready():
	pass
	



func _on_AmmoBox_body_entered(body):
	if body.name == "Player":
		Globals.playerAmmo += ammunition
		
		queue_free()
