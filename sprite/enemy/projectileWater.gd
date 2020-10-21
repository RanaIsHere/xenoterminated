extends Area2D

export var projectileSpeed = 400
export var projectileDamage = 5
var texture = preload("res://sprite/enemy/projectileWater.png")
var hurtP = preload("res://sprite/player/HurtParticle.tscn").instance()


func _ready():
	$Sprite.texture = texture

func _physics_process(delta):
	position += transform.x * projectileSpeed * delta



func _on_projectileWater_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.name == "Player":
		body.add_child(hurtP)
		queue_free()
		
		Globals.playerHealth -= projectileDamage
		if Globals.playerHealth == 0 or Globals.playerHealth < 0:
			Globals.deathType = "bullet"
			
