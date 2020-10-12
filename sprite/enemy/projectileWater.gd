extends Area2D

export var projectileSpeed = 400
export var projectileDamage = 5
var texture = preload("res://sprite/enemy/projectileWater.png")


func _ready():
	$Sprite.texture = texture

func _physics_process(delta):
	position += transform.x * projectileSpeed * delta



func _on_projectileWater_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.name == "Player":
		queue_free()
		
		Globals.playerHealth -= projectileDamage
		if Globals.playerHealth == 0 or Globals.playerHealth < 0:
			Globals.deathType = "bullet"
			
