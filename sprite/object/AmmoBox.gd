extends Area2D


export var ammunition = 5

func _ready():
	pass


func _on_AmmoBox_body_entered(body):
	if body.name == "Player":
		if Globals.playerAmmo > 90 or Globals.playerAmmo == 90:
			Globals.playerAmmo = Globals.playerAmmo
		else:
			Globals.playerAmmo += ammunition
			queue_free()
	
