extends KinematicBody2D

const playerSpeed = 300

export var MAXBATT = 20
export var MAXAMMO = 90

var velocity = Vector2.ZERO

var idleTexture = preload("res://sprite/player/bullet_hell/shipIdle.png")
var tiltLeftTex = preload("res://sprite/player/bullet_hell/shipTiltLeft.png")
var tiltRightTex = preload("res://sprite/player/bullet_hell/shipTiltRight.png")

export (PackedScene) var bullet = preload("res://sprite/player/bullet.tscn")
export (PackedScene) var scanArea = preload("res://sprite/player/ScanArea.tscn")

export (PackedScene) var pauseScene = preload("res://GUI/PauseScreen.tscn")

var shakeScreen = preload("res://sprite/player/ShakeHit.tscn").instance()

func _ready():
	$Sprite.texture = idleTexture
	
	Globals.playerHealth = 100
	Globals.playerAmmo = MAXAMMO * 100
	Globals.playerBattery = MAXBATT * 100
	Globals.playerSpeed = playerSpeed
	
	Globals.researchPoint = 0
	Globals.soldierPoint = 0
	
	Globals.researchPoint = Globals.stage_1_res
	Globals.soldierPoint = Globals.stage_1_sol

func observe():
	var s_a = scanArea.instance()
	
	#owner.add_child(shakeScreen)
	
	owner.add_child(s_a)
	s_a.transform = $gun.global_transform
	Globals.playerBattery -= 1

func shoot():
	var b_t = bullet.instance()
	
	$AudioStreamPlayer.playing = true
	owner.add_child(b_t)
	b_t.transform = $gun.global_transform
	Globals.playerAmmo -= 1

func pause():
	var p = pauseScene.instance()
	
	owner.get_node("GUI").add_child(p)

func get_input():
	velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		velocity.y -= 1
		$Sprite.texture = idleTexture
	if Input.is_action_pressed("down"):
		velocity.y += 1
		$Sprite.texture = idleTexture
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$Sprite.texture = tiltRightTex
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$Sprite.texture = tiltLeftTex
	if Input.is_action_pressed("slowdown"):
		Globals.playerSpeed = 200
	else:
		Globals.playerSpeed = 300	
	
	if Input.is_action_just_pressed("pause"):
		pause()
	if velocity == Vector2.ZERO:
		if Globals.researchPoint == 0 or Globals.allowRs == true:
			if Input.is_action_just_pressed("shoot") and Globals.playerAmmo != 0:
				if owner.get_node("GUI").get_node_or_null("PauseScreen"):
					if owner.get_node("GUI").get_node("PauseScreen").is_processing_unhandled_input():
						return
				else:
					shoot()
		
		if Globals.soldierPoint == 0 or Globals.allowRs == true:
			if Input.is_action_just_pressed("observe"):
				observe()
			

	velocity = velocity.normalized() * Globals.playerSpeed

	velocity = move_and_slide(velocity, velocity, false, 4, PI / 4, false)

func _process(_delta):
	if Globals.playerAmmo < 0:
		Globals.playerAmmo = 0
	if Globals.playerAmmo > MAXAMMO * 100:
		Globals.playerAmmo = MAXAMMO * 100
	if Globals.playerBattery < 0:
		Globals.playerBattery = 0

func _physics_process(_delta):
	if Globals.allowInput == true:
		get_input()
	
	
	look_at(get_global_mouse_position())
	$gun.look_at(get_global_mouse_position())
