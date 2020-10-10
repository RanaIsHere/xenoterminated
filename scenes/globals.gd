extends Node

var playerHealth = 100
var playerAmmo

var allowInput = true
var researchPoint = 0
var soldierPoint = 0

func _process(delta):
	if Globals.playerHealth < 0:
		playerHealth = 0
