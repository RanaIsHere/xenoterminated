extends Node

var playerHealth = 100
var playerAmmo
var playerBattery
var playerSpeed

var allowInput = true
var researchPoint = 0
var soldierPoint = 0

var collidedBodies : Array # Neverao Array Collider

var approachedBodies : Array # Hobrun Array Collider

func _process(delta):
	if Globals.playerHealth < 0:
		playerHealth = 0
	#print (collidedBodies)