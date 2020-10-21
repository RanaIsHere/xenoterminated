extends Node

var globalTileMap

var nextStage : String
var stage_1 = "res://scenes/world/stage_1.tscn"
var stage_2 = "res://scenes/world/stage_2.tscn"
var stage_3 = "res://scenes/world/stage_3.tscn"

var ending_1 = "res://GUI/TextInterface_Ending_1.tscn"
var ending_2 = "res://GUI/TextInterface_Ending_2.tscn"

var stage_1_res : int = 0
var stage_1_sol : int = 0


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
