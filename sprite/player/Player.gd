extends KinematicBody2D

var allowShot = 0

const playerSpeed = 200

export var MAXBATT = 20
export var MAXAMMO = 90

var velocity = Vector2.ZERO

onready var playerAnimated = $AnimatedSprite

export (PackedScene) var bullet = preload("res://sprite/player/bullet.tscn")
export (PackedScene) var scanArea = preload("res://sprite/player/ScanArea.tscn")

export (PackedScene) var pauseScene = preload("res://GUI/PauseScreen.tscn")

func _ready():
	playerAnimated.connect("animation_finished", self, "idle")
	
	Globals.playerHealth = 100
	Globals.playerAmmo = MAXAMMO
	Globals.playerBattery = MAXBATT
	Globals.playerSpeed = playerSpeed
	
	Globals.researchPoint = 0
	Globals.soldierPoint = 0

func observe():
	$AnimationPlayer.play("ShakeCamera")
	var s_a = scanArea.instance()
		
	owner.add_child(s_a)
	s_a.transform = $gun.global_transform
	Globals.playerBattery -= 1

func shoot():
	$AnimationPlayer.play("ShakeCamera")
	var b_t = bullet.instance()
	playerAnimated.animation = "shoot"
	Globals.allowInput = false
	
	$AudioStreamPlayer.playing = true
	owner.add_child(b_t)
	b_t.transform = $gun.global_transform
	Globals.playerAmmo -= 1
	allowShot = 1


func walk():
	playerAnimated.animation = "walk"

func idle():
	if playerAnimated.animation == "shoot":
		playerAnimated.animation = "idle"
		Globals.allowInput = true
		$AudioStreamPlayer.playing = false
		allowShot = 0
	else:
		playerAnimated.animation = "idle"

func pause():
	var p = pauseScene.instance()
	
	owner.get_node("GUI").add_child(p)

func get_input():
	velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		velocity.y -= 1
		walk()
	if Input.is_action_pressed("down"):
		velocity.y += 1
		walk()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		walk()
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		walk()
	if Input.is_action_just_pressed("pause"):
		pause()
	if velocity == Vector2.ZERO:
		$Walk.playing = false
		if Globals.researchPoint == 0 or Globals.allowRs == true:
			if Input.is_action_just_pressed("shoot") and allowShot == 0 and Globals.playerAmmo != 0:
				shoot()
		
		if Globals.soldierPoint == 0 or Globals.allowRs == true:
			if Input.is_action_just_pressed("observe"):
				observe()
	else:
		if $Walk.playing == false:
			$Walk.playing = true	
			

	velocity = velocity.normalized() * Globals.playerSpeed

	velocity = move_and_slide(velocity, velocity, false, 4, PI / 4, false)

func _process(_delta):
	if Globals.playerAmmo < 0:
		Globals.playerAmmo = 0
	if Globals.playerAmmo > MAXAMMO:
		Globals.playerAmmo = MAXAMMO
	if Globals.playerBattery < 0:
		Globals.playerBattery = 0

func _physics_process(_delta):
	if Globals.allowInput == true:
		get_input()
	
	
	look_at(get_global_mouse_position())
	$gun.look_at(get_global_mouse_position())
