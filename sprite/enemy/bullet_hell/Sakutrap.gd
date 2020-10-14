extends KinematicBody2D

var health = 200
var researchLimit = 200

export (PackedScene) var proj = preload("res://sprite/enemy/bullet_hell/projectilePlasma.tscn")

var stages = 0

var oneShot = 0

export var c_t = 0.0 # firerate
export var max_t = 0.4 # max time

export var c_st = 0.0 # current stage time
export var max_st = 1.0 # max stage time

var Current = 0.0

var colliders

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	if colliders != null:
		look_at(colliders.position)
		
		match stages: # stage time setter
			0: # nor
				max_st = 5.0
			1: # spi
				max_st = 8.0
			2: # nor
				max_st = 5.0
			3: # spi
				max_st = 8.0
			4: # wait stage
				max_st = 2.0
			5: # homing plasma
				max_st = 10.0
		
		#oneShot = 0
		if c_st < max_st: # tick to max stage time
			c_st += delta
		
		if c_st > max_st: # if more than max, back to zero and add one
			c_st = 0.0
			stages += 1
		
		#if c_t < max_t:
			#c_t += delta
	
		#if c_t > max_t and oneShot == 0:
		#	c_t = 0.0
			#oneShot = 1
			# execute stages
		if stages == 0: 
			normalShoot(0.4, delta)
		elif stages == 1:
			spinShoot(20, 0.1, delta)
		elif stages == 2:
			normalShoot(0.4, delta)
		elif stages == 3:
			spinShoot(20, 0.1, delta)
		elif stages == 4:
			return
		elif stages == 5:
			spinShoot(6, 0.1, delta)
			normalShoot(0.4, delta)
		elif stages == 6:
			normalShoot(0.2, delta)
		elif stages == 7:
			stages = 0

func spinShoot(var rotationRange, var MaxTime, var Delta):
	var p = proj.instance()
	p.texture = preload("res://sprite/enemy/bullet_hell/bullet.png")
	max_t = MaxTime #0.1
	
	
	if Current < MaxTime:
		Current += Delta
		
	if Current > MaxTime:
		Current = 0.0
		
		get_parent().add_child(p)
	
		for i in range(rotationRange):
			$AnimatedSprite/Beak2.rotation_degrees += i
	
			p.transform = $AnimatedSprite/Beak2.global_transform
	
		p = null
	
	
func normalShoot(var MaxTime, var Delta):
	var p = proj.instance()
	p.texture = preload("res://sprite/enemy/bullet_hell/bullet.png")
	$AnimatedSprite/Beak.look_at(colliders.position)
	max_t = MaxTime #0.4
	
	if Current < MaxTime:
		Current += Delta
		
	if Current > MaxTime:
		Current = 0.0
		
		get_parent().add_child(p)
		p.transform = $AnimatedSprite/Beak.global_transform
	
		p = null
	
	#print(Current)

func _on_HurtDetection_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()



func _on_AreaDetection_body_entered(body):
	if body.name == "Ship":
		colliders = body
		set_physics_process(true)
