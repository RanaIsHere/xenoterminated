extends KinematicBody2D

export (PackedScene) var projWater = preload("res://sprite/enemy/projectileWater.tscn")

var c_t : float = 0.0 # fire time
var max_t : float = 1.5 #fire rate

var oneShot = 0

export var health = 2

export var collided : Array

var col

func ready():
	set_physics_process(false)
	col = null

func shoot():
	var p_w1 = projWater.instance()
	var p_w2 = projWater.instance()
	
	owner.add_child(p_w1)
	p_w1.transform = $AnimatedSprite/left.global_transform
	owner.add_child(p_w2)
	p_w2.transform = $AnimatedSprite/right.global_transform
	
	$AnimatedSprite/AudioStreamPlayer2D.playing = true
	
func _process(delta):
	#oneShot = 0
	
	#look_at(get_node("Player").position)
	#$AnimatedSprite/left.look_at(get_node("Player").position)
	#$AnimatedSprite/right.look_at(get_node("Player").position)
	#if c_t < max_t:
	#	c_t += delta
	#
	#if c_t > max_t and oneShot == 0:
	#	c_t = 0.0
	#	oneShot = 1
	#	shoot()
		
	Globals.collidedBodies = collided
	
	#print(c_t)
	#print(Globals.collidedBodies)
	
func _physics_process(delta):
	if col != null:
		look_at(col.position)
		$AnimatedSprite/left.look_at(col.position)
		$AnimatedSprite/right.look_at(col.position)
	
	
	#if Globals.collidedBodies.size() != 0:
	#	look_at(Globals.collidedBodies[0].position)
	#	$AnimatedSprite/left.look_at(Globals.collidedBodies[0].position)
	#	$AnimatedSprite/right.look_at(Globals.collidedBodies[0].position)
	
	oneShot = 0
	
	if c_t < max_t:
		c_t += delta
	
	if c_t > max_t and oneShot == 0:
		c_t = 0.0
		oneShot = 1
		shoot()

func _on_areaRadius_body_entered(body):
	if body.name == "Player":
		collided.append(body)
		col = body
		set_physics_process(true)


func _on_areaRadius_body_exited(body):
	if body.name == "Player":
		collided.remove(collided.find(body))
		col = null
		set_physics_process(false)
