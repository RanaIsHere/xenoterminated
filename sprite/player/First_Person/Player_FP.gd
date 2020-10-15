extends KinematicBody

onready var c = $Spatial/Camera

var oneShot = 0

var playerSpeed = 4
var gravity = 2
var mouseSensitivity = 0.002

var velocity = Vector3.ZERO

export (PackedScene) var pauseScene = preload("res://GUI/PauseScreen.tscn")
export (PackedScene) var bullet = preload("res://sprite/player/First_Person/Bullet3D.tscn")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func pause():
	var p = pauseScene.instance()
	
	owner.add_child(p)

func shoot():
	if $Spatial/Muzzle/Particles.emitting == false:
		$Spatial/Muzzle/Particles.emitting = true
		$Spatial/Muzzle/AudioStreamPlayer3D.playing = true
		
		if $Spatial/Muzzle/RayCast.is_colliding():
			pass
		
		#var b = bullet.instance()
			
		#owner.add_child(b)
		#b.transform = $Spatial/Muzzle.global_transform
		#b.add_to_group("bullet")
		#b = null
		

func _get_input():
	var velocityDir = Vector3.ZERO
	$Spatial/Muzzle/RayCast.force_raycast_update()
	
	if Input.is_action_pressed("observe"):
		Input.set_mouse_mode(!Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("pause"):
		pause()
	if Input.is_action_just_pressed("shoot3D") and $Spatial/Muzzle/Particles.emitting == false and $Spatial/Muzzle/AudioStreamPlayer3D.playing == false:
		shoot()
	
	
	if Input.is_action_pressed("up"):
		velocityDir += -c.global_transform.basis.z
	if Input.is_action_pressed("down"):
		velocityDir += c.global_transform.basis.z
	if Input.is_action_pressed("left"):
		velocityDir += -c.global_transform.basis.x
	if Input.is_action_pressed("right"):
		velocityDir += c.global_transform.basis.x
	
	if Input.is_action_pressed("rotate_l"):
		rotation_degrees.y += 2
	if Input.is_action_pressed("rotate_r"):
		rotation_degrees.y -= 2
	
	velocityDir = velocityDir.normalized()
		
	return velocityDir

func inputMovement(var delta):
	velocity.y += -gravity * delta
	var returnedVelocity = _get_input() * playerSpeed
	
	velocity.z = returnedVelocity.z
	velocity.x = returnedVelocity.x
	
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, PI / 4, false)
	
	if velocity.z != 0 or velocity.x != 0:
		if $Spatial/Walk.playing == false:
			$Spatial/Walk.playing = true
	else:
		if $Spatial/Walk.playing == true:
			$Spatial/Walk.playing = false
	

func _unhandled_input(event):
	if event is InputEventMouseMotion: #and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$Spatial.rotate_y(-event.relative.x * mouseSensitivity)
		#$Spatial.rotate_x(-event.relative.y * mouseSensitivity)
		$Spatial.rotation.x = clamp($Spatial.rotation.x, -1.2, 1.2)
		$Spatial.rotation.z = 0


func _physics_process(delta):
	inputMovement(delta)
	
	
