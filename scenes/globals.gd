extends Node

var globalTileMap

var stage_1 = "res://scenes/world/stage_1.tscn"
var stage_2 = "res://scenes/world/stage_2.tscn"

var playerHealth = 100
var playerAmmo
var playerBattery
var playerSpeed

var allowRs : bool = false
var allowInput = true
var researchPoint = 0
var soldierPoint = 0
var kingPoint = 0

var bossHealth = 100

var collidedBodies : Array # Neverao Array Collider

var approachedBodies : Array # Hobrun Array Collider

var deathType
var currentStage

func _process(_delta):
	if Globals.playerHealth < 0:
		playerHealth = 0
	#print (collidedBodies)
