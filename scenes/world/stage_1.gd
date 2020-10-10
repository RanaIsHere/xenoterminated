extends Node2D

func _process(_delta):	
	var tileMap = $theCliffsground.world_to_map($Player.position)
	var indexTile = $theCliffsground.get_cellv(Vector2(tileMap.x, tileMap.y))
	
	if indexTile == -1:
		Globals.playerHealth = 0
	
	#print(indexTile)

func _physics_process(delta):
	if get_node("Neverao"):
		$Neverao.look_at(get_node("Player").position)
		$Neverao/AnimatedSprite/left.look_at(get_node("Player").position)
		$Neverao/AnimatedSprite/right.look_at(get_node("Player").position)
	
	if get_node("Neverao2"):
		$Neverao2.look_at(get_node("Player").position)
		$Neverao2/AnimatedSprite/left.look_at(get_node("Player").position)
		$Neverao2/AnimatedSprite/right.look_at(get_node("Player").position)
