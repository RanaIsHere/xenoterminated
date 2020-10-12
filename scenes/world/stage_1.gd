extends Node2D

var dcShot = 0
var exShot = 0

onready var curbat = $Player.MAXBATT

var warnAlert = preload("res://scenes/WarnAlert.tscn").instance()

#var playerSpawnPoint = $playerSpawn.position
#var playerBossPoint = $BossStage_1.position


func _ready():
	OS.set_window_title("Xenoterminated - Alpha Cliff")
	dcShot = 0
	exShot = 0
	Globals.currentStage = "res://scenes/world/stage_1.tscn"
	Globals.deathType = null
	Globals.allowInput = true
	Globals.globalTileMap = null
	
	$Player.position = $playerSpawn.position
	
	print (curbat)
	print(get_tree().get_nodes_in_group("enemies").size())
	
func _process(_delta):	
	var tileMap = $theCliffsground.world_to_map($Player.position)
	var indexTile = $theCliffsground.get_cellv(Vector2(tileMap.x, tileMap.y))
	
	Globals.globalTileMap = tileMap
	
	if indexTile == -1:
		Globals.playerHealth = 0
		Globals.deathType = "fall"
		get_tree().change_scene("res://scenes/deathScene_fall.tscn")
	if indexTile == 3:
		if waitTimeBreak(tileMap).is_valid():
			print("valid")
		else:
			print("non")
	
	if indexTile == 4:
		Globals.playerSpeed = 150
	else:
		Globals.playerSpeed = 200

	
	if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0 and Globals.deathType == "fall":
		dcShot = 1
		Globals.allowInput = false
		$Player.queue_free()
		get_tree().change_scene("res://scenes/deathScene_fall.tscn")
	if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0 and Globals.deathType == "bullet":
		dcShot = 1
		Globals.allowInput = false
		$Player.queue_free()
		get_tree().change_scene("res://scenes/deathScene_1.tscn")
	if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0 and Globals.deathType == "trampled":
		dcShot = 1
		Globals.allowInput = false
		$Player.queue_free()
		get_tree().change_scene("res://scenes/deathScene_trampled.tscn")
	if Globals.bossHealth == 0 or Globals.bossHealth < 0 and exShot == 0:
			exShot += 1
			$DeathExplosion.emitting = true
			if exShot > 30:
				$DeathExplosion.emitting = false
				Globals.bossHealth = 100
				exShot = 0
		
	#if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0:
	#	dcShot == 1
	#	get_tree().change_scene()
	#print(indexTile)

func waitTimeBreak(var tileMap):
	yield(get_tree().create_timer(0.2), "timeout")
	
	$theCliffsground.set_cellv(tileMap, -1)


func _on_moveTo_1_body_entered(body):
	if body.name == "Player":
		if Globals.researchPoint == 36 or Globals.researchPoint >= 36 or Globals.soldierPoint == 36 or Globals.soldierPoint >= 36:
			body.position = $BossStage_1.position
			
			body.MAXBATT = 120
			Globals.playerBattery = body.MAXBATT
			Globals.allowRs = true
		else:
			$GUI.add_child(warnAlert)


func _on_moveTo_2_body_entered(body):
	if body.name == "Player":
		body.position = $playerSpawn.position
		body.MAXBATT = curbat
		Globals.playerBattery = body.MAXBATT
		Globals.allowRs = false
		


func _on_moveTo_1_body_exited(body):
	if body.name == "Player":
		$GUI.remove_child(warnAlert)
