extends Area2D

export var projectileSpeed = 400
export var projectileDamage = 8
var texture = preload("res://sprite/enemy/bullet_hell/bullet.png")


func _ready():
	$Sprite.texture = texture

func _physics_process(delta):
	position += transform.x * projectileSpeed * delta



func _on_projectilePlasma_body_entered(body):
	if body.is_in_group("invincible"):
		queue_free()
	if body.name == "Ship":
		Globals.playerHealth -= projectileDamage
		Globals.deathType = "bullet"
		
		queue_free()
