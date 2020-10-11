extends Node2D

func _ready():
	OS.set_window_title("Xenoterminated - Alpha Cliff")

func _process(_delta):	
	var tileMap = $theCliffsground.world_to_map($Player.position)
	var indexTile = $theCliffsground.get_cellv(Vector2(tileMap.x, tileMap.y))
	
	if indexTile == -1:
		Globals.playerHealth = 0
	
	if indexTile == 3:
		breakTile(tileMap)
	
	if indexTile == 4:
		Globals.playerSpeed = 150
	else:
		Globals.playerSpeed = 200
	
	#print(indexTile)

func breakTile(var tileMap):
	yield(get_tree().create_timer(0.2), "timeout")
	
	$theCliffsground.set_cellv(tileMap, -1)	

func _physics_process(delta):
	#if  $Neverao != null:
	#	$Neverao.look_at(get_node("Player").position)
	#	$Neverao/AnimatedSprite/left.look_at(get_node("Player").position)
	#	$Neverao/AnimatedSprite/right.look_at(get_node("Player").position)
	
	#if $Neverao2 != null:
	#	$Neverao2.look_at(get_node("Player").position)
	#	$Neverao2/AnimatedSprite/left.look_at(get_node("Player").position)
	#	$Neverao2/AnimatedSprite/right.look_at(get_node("Player").position)
	pass
