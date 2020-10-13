extends KinematicBody2D

var health = 300
var researchLimit = 300

export (PackedScene) var proj = preload("res://sprite/enemy/bullet_hell/projectilePlasma.tscn")

var stages = 0

var oneShot = 0

export var c_t = 0.0
export var max_t = 0.4

var colliders

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	if colliders != null:
		look_at(colliders.position)
		
		#oneShot = 0
	
		if c_t < max_t:
			c_t += delta
	
		if c_t > max_t and oneShot == 0:
			c_t = 0.0
			#oneShot = 1
			if stages == 0:
				#normalShoot()
				spinShoot()

func spinShoot():
	var p = proj.instance()
	p.texture = preload("res://sprite/enemy/bullet_hell/bullet.png")
	max_t = 0.1
	
	get_parent().add_child(p)
	
	for i in range(20):
		$AnimatedSprite/Beak.rotation_degrees += i
	
		p.transform = $AnimatedSprite/Beak.global_transform
	
	
func normalShoot():
	var p = proj.instance()
	p.texture = preload("res://sprite/enemy/bullet_hell/bullet.png")
	$AnimatedSprite/Beak.look_at(colliders.position)
	max_t = 0.4
	
	
	get_parent().add_child(p)
	p.transform = $AnimatedSprite/Beak.global_transform

func _on_HurtDetection_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()



func _on_AreaDetection_body_entered(body):
	if body.name == "Ship":
		colliders = body
		set_physics_process(true)
