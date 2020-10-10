extends Control

func _ready():
	pass
	
func _process(delta):
	$Panel/AmmoPoint.text = "Ammo: " + str(Globals.playerAmmo)
	$Panel/HealthPoint.text = "Health: " + str(int(Globals.playerHealth))
	
	$Panel/ResearchPoint.text = str(Globals.researchPoint)
	$Panel/SoldierPoint.text = str(Globals.soldierPoint)
