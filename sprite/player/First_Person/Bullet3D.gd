extends Area

func _ready():
	pass

func _physics_process(delta):
	transform.basis.z += transform.basis.z * 10 * delta
	
