extends Node2D

export var c_t = 0.0
export var max_t = 1.0
var oneShot = 0

var oneC = 0
var dcShot = 0
var exShot = 0

var shooting_type : String = "normal"
var shootingNum = 0

var randSpawn_1 = 0
var randSpawn_2 = 0

var warnAlert = preload("res://scenes/WarnAlert.tscn").instance()

var pinkofly = preload("res://sprite/player/bullet_hell/BH_Pinkofly.tscn")
var nervesap = preload("res://sprite/enemy/bullet_hell/Nervesap.tscn")
var sakutrap = preload("res://sprite/enemy/bullet_hell/Sakutrap.tscn")

export (PackedScene) var warn = preload("res://GUI/WarnStage_2.tscn").instance()

func _ready():
	OS.set_window_title("Xenoterminated - Alpha Cliff")
	dcShot = 0
	exShot = 0
	Globals.currentStage = "res://scenes/world/stage_1.tscn"
	Globals.deathType = null
	Globals.allowInput = true
	Globals.globalTileMap = null
	
	Globals.soldierPoint = Globals.stage_1_sol
	Globals.researchPoint = Globals.stage_1_res
	
	Input.set_mouse_mode(!Input.MOUSE_MODE_CAPTURED)
	
	$Ship.position = $playerSpawn.position

	print(get_tree().get_nodes_in_group("enemies").size())

func pinkoflies(var limit):
	if get_tree().get_nodes_in_group("pinkofly").size() < limit:
		var p_f = pinkofly.instance()
		var os = 0
		
		if os == 0:
			add_child(p_f)
			os += 1
		
		randSpawn_1 = randi() % 8 + 1
		
		match randSpawn_1:
			1:
				p_f.duplicate()
				p_f.position = $EnemySpawn_1.position
				p_f.add_to_group("pinkofly")
			2:
				p_f.duplicate()
				p_f.position = $EnemySpawn_2.position
				p_f.add_to_group("pinkofly")
			3:
				p_f.duplicate()
				p_f.position = $EnemySpawn_3.position
				p_f.add_to_group("pinkofly")
			4:
				p_f.duplicate()
				p_f.position = $EnemySpawn_4.position
				p_f.add_to_group("pinkofly")
			5:
				p_f.duplicate()
				p_f.position = $EnemySpawn_5.position
				p_f.add_to_group("pinkofly")
			6:
				p_f.duplicate()
				p_f.position = $EnemySpawn_6.position
				p_f.add_to_group("pinkofly")
			7:
				p_f.duplicate()
				p_f.position = $EnemySpawn_7.position
				p_f.add_to_group("pinkofly")
			8:
				p_f.duplicate()
				p_f.position = $EnemySpawn_8.position
				p_f.add_to_group("pinkofly")
		
		if shooting_type != "randomized":
			p_f.look_at($Ship.position)
		else:
			for i in range(20):
				p_f.duplicate()
				$EnemySpawn_1.rotation_degrees += i
				$EnemySpawn_2.rotation_degrees += i
				$EnemySpawn_3.rotation_degrees += i
				$EnemySpawn_4.rotation_degrees += i
				$EnemySpawn_5.rotation_degrees += i
				$EnemySpawn_6.rotation_degrees += i
				$EnemySpawn_7.rotation_degrees += i
				$EnemySpawn_8.rotation_degrees += i
				p_f.rotation_degrees = $EnemySpawn_1.rotation_degrees
		if shooting_type == "randomized_straight":
			for i in range(15):
				p_f.duplicate()
				$EnemySpawn_1.rotation_degrees += i
				$EnemySpawn_2.rotation_degrees += i
				$EnemySpawn_3.rotation_degrees += i
				$EnemySpawn_4.rotation_degrees += i
				$EnemySpawn_5.rotation_degrees += i
				$EnemySpawn_6.rotation_degrees += i
				$EnemySpawn_7.rotation_degrees += i
				$EnemySpawn_8.rotation_degrees += i
				p_f.rotation_degrees = $EnemySpawn_1.rotation_degrees
		#print(p_f.position)
		p_f = null

func nervesapper(var limit):
	if get_tree().get_nodes_in_group("enemies").size() < limit:
		var p_f = nervesap.instance()
		var os = 0
		
		if os == 0:
			add_child(p_f)
			os += 1
		
		randSpawn_2 = randi() % 8 + 1	
		
		match randSpawn_2:
			1:
				p_f.duplicate()
				p_f.position = $EnemySpawn_1.position
				p_f.add_to_group("enemies")
			2:
				p_f.duplicate()
				p_f.position = $EnemySpawn_2.position
				p_f.add_to_group("enemies")
			3:
				p_f.duplicate()
				p_f.position = $EnemySpawn_3.position
				p_f.add_to_group("enemies")
			4:
				p_f.duplicate()
				p_f.position = $EnemySpawn_4.position
				p_f.add_to_group("enemies")
			5:
				p_f.duplicate()
				p_f.position = $EnemySpawn_5.position
				p_f.add_to_group("enemies")
			6:
				p_f.duplicate()
				p_f.position = $EnemySpawn_6.position
				p_f.add_to_group("enemies")
			7:
				p_f.duplicate()
				p_f.position = $EnemySpawn_7.position
				p_f.add_to_group("enemies")
			8:
				p_f.duplicate()
				p_f.position = $EnemySpawn_8.position
				p_f.add_to_group("enemies")
		p_f = null

func boss_sakutrap(var limit):
	if get_tree().get_nodes_in_group("boss").size() < limit:
		var st = sakutrap.instance()
		var os = 0
		
		if os == 0:
			os += 1
			add_child(st)
			st.add_to_group("boss")
			st.position = $BossStage_2.position
		st = null
		
func _process(delta):	
	$ParallaxBackground.scroll_offset.y += 10 * delta
	
	if shooting_type == "normal":
		max_t = 15.0
	elif shooting_type == "normal_2":
		max_t = 5.0
	elif shooting_type == "aim_shoot":
		max_t = 10.0
	elif shooting_type == "straight_lines":
		max_t = 5.0
	elif shooting_type == "straight_lines_aim":
		max_t = 15.0
	elif shooting_type == "randomized":
		max_t = 10.0
	elif shooting_type == "straight_lines_aim_extreme":
		max_t = 8.0
	elif shooting_type == "randomized_straight":
		max_t = 8.0
	elif shooting_type == "healing_stage":
		max_t = 5.0
	elif shooting_type == "boss_fight":
		max_t = 90.0
	
	if c_t < max_t:
		c_t += delta
	
	if c_t > max_t:
		c_t = 0.0
		shootingNum += 1
		
		
	match shootingNum:
		0:
			shooting_type = "normal"
		1:
			shooting_type = "aim_shoot"
		2:
			shooting_type = "straight_lines"
		3:
			shooting_type = "straight_lines_aim"
		4:
			shooting_type = "randomized"
		5:
			shooting_type = "straight_lines_aim_extreme"
		6:
			shooting_type = "aim_shoot"
		7:
			shooting_type = "randomized_straight"
		8:
			shooting_type = "normal_2"
		9:
			shooting_type = "healing_stage"
		10:
			shooting_type = "boss_fight"
	
	if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0 and Globals.deathType == "bullet":
		dcShot = 1
		Globals.allowInput = false
		$Ship.queue_free()
		get_tree().change_scene("res://scenes/Cutscene_Death_Ship.tscn")
		#get_tree().change_scene("res://scenes/deathScene_1.tscn")
	if Globals.playerHealth < 0 or Globals.playerHealth == 0 and dcShot == 0 and Globals.deathType == "trampled":
		dcShot = 1
		Globals.allowInput = false
		$Ship.queue_free()
		get_tree().change_scene("res://scenes/Cutscene_Death_Ship.tscn")
		#get_tree().change_scene("res://scenes/deathScene_trampled.tscn")
	if Globals.bossHealth == 0 or Globals.bossHealth < 0 and exShot == 0:
			exShot += 1
			$DeathExplosion.emitting = true
			if exShot > 30:
				$DeathExplosion.emitting = false
				if Globals.stage_1_sol != 0 or Globals.soldierPoint >= 36:
					Globals.nextStage = Globals.ending_1
				elif Globals.stage_1_res != 0 or Globals.researchPoint >= 36:
					Globals.nextStage = Globals.ending_2
				get_tree().change_scene("res://scenes/MoveBetweenScene.tscn")
				Globals.bossHealth = 100
				exShot = 0
	
	match shooting_type:
		"normal":
			#print("none yet")
			if oneC == 0:
				oneC += 1
				$GUI.add_child(warn)
				
		"normal_2":
			return
		"aim_shoot":
			pinkoflies(4)
			
			if oneC == 1:
				oneC = -1
				$GUI.remove_child(warn)
			
			#print(randSpawn)
		"straight_lines":
			nervesapper(200)
		"straight_lines_aim":
			nervesapper(200)
			pinkoflies(5)
		"randomized":
			pinkoflies(20)
		"straight_lines_aim_extreme":
			pinkoflies(20)
			nervesapper(300)
		"randomized_straight":
			nervesapper(300)
			pinkoflies(15)
		"healing_stage":
			#Globals.playerHealth = 100
			
			var enemies = get_tree().get_nodes_in_group("enemies")
			var pinko = get_tree().get_nodes_in_group("pinkofly")
			
			for i in enemies:
				i.free()
			for i in pinko:
				i.free()
		"boss_fight":
			nervesapper(0)
			pinkoflies(0)
			boss_sakutrap(1)
			c_t = 0.0
			

	if shootingNum == 10:
		if $BossMusic.playing == false:
			$BossMusic.playing = true
	
	if Globals.soldierPoint == 1 and Globals.researchPoint == 1:
		get_tree().change_scene(Globals.stage_2)
		
func waitTimeBreak(var tileMap):
	yield(get_tree().create_timer(0.2), "timeout")
	
	$theCliffsground.set_cellv(tileMap, -1)
