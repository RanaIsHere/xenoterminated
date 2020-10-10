extends KinematicBody2D

export (PackedScene) var projWater = preload("res://sprite/enemy/projectileWater.tscn")

var c_t : float = 0.0 # fire time
var max_t : float = 1.5 #fire rate

var oneShot = 0

func shoot():
	var p_w1 = projWater.instance()
	var p_w2 = projWater.instance()
	
	owner.add_child(p_w1)
	p_w1.transform = $AnimatedSprite/left.global_transform
	owner.add_child(p_w2)
	p_w2.transform = $AnimatedSprite/right.global_transform
	
func _process(delta):
	oneShot = 0
	
	#look_at(get_node("Player").position)
	#$AnimatedSprite/left.look_at(get_node("Player").position)
	#$AnimatedSprite/right.look_at(get_node("Player").position)
	if c_t < max_t:
		c_t += delta
	
	if c_t > max_t and oneShot == 0:
		c_t = 0.0
		oneShot = 1
		shoot()
		
	print(c_t)
	
