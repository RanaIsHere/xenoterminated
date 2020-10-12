extends KinematicBody2D

export var health = 1
var oneShot = 0

var shootingType = 0
var timeUntilDone = 0

export (PackedScene) var Projectile = preload("res://sprite/enemy/projectileWater.tscn")
var HobrunProj = preload("res://sprite/enemy/HobrunDead.png")

var c_t : float = 0.0 # fire time
var max_t : float = 2 #fire rate

var colliders

func _ready():
	set_physics_process(false)
	colliders = null
	timeUntilDone = 0
	
func shoot( var delta ):
	var p_h = Projectile.instance()
	p_h.texture = HobrunProj
	p_h.projectileDamage = 10
	
	if colliders != null:
		if shootingType == 0: #circular shot
			owner.add_child(p_h)
			if timeUntilDone < 5:
				for i in range(20):
					p_h.duplicate()
					$Position2D.rotation_degrees += i
					p_h.transform = $Position2D.global_transform
				#print(timeUntilDone)
			else:
				shootingType = 1
				timeUntilDone = 0
		
		if shootingType == 1: # slow circular shot
			owner.add_child(p_h)
			if timeUntilDone < 5:
				for i in range(20):
					p_h.duplicate()
					$Position2D.rotation_degrees += i
					p_h.transform = $Position2D.global_transform
				#print(timeUntilDone)
			else:
				shootingType = 2
				timeUntilDone = 0
		
		if shootingType == 2: # aim and shoot
			if timeUntilDone < 12:
				owner.add_child(p_h)
				p_h.duplicate()
				$Position2D.look_at(colliders.position)
				p_h.transform = $Position2D.global_transform
			else:
				shootingType = 0
				timeUntilDone = 0
	

func _physics_process(delta):
	#if colliders != null:
	##	if shootingType == 0:
	#		$Position2D.look_at(colliders.position)
			
	oneShot = 0
	
	if shootingType == 0:
		max_t = 0.09
		timeUntilDone += delta
	elif shootingType == 1:
		max_t = 0.5
		timeUntilDone += delta
	elif shootingType == 2:
		max_t = 1
		timeUntilDone += delta
	
	if c_t < max_t:
		c_t += delta
	
	if c_t > max_t and oneShot == 0:
		c_t = 0.0
		oneShot = 1
		shoot(delta)

func _on_areaRadius_body_entered(body):
	if body.name == "Player":
		colliders = body
		set_physics_process(true)


func _on_areaRadius_body_exited(body):
	if body.name == "Player":
		colliders = null
		set_physics_process(true)
