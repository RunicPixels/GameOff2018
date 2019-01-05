extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var max_speed = 100
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
    	var new_speed = get_linear_velocity().normalized()
    	new_speed *= max_speed
    	set_linear_velocity(new_speed)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
