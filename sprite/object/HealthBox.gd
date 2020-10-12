extends Area2D

export var heal = 10

func _ready():
	pass


func _on_HealthBox_body_entered(body):
	if body.name == "Player":
		if Globals.playerHealth > 100 or Globals.playerHealth == 100:
			Globals.playerHealth = Globals.playerHealth
		else:
			Globals.playerHealth += heal
			queue_free()
		
