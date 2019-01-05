extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var newScale = scale.x #* rand_range(0.999,1.001)

	newScale = newScale + 0.001 * sin(OS.get_ticks_msec() * 0.01 * Engine.time_scale)
		
	if(newScale > 1.2):
		newScale = 1.15
	if(newScale < 0.8):
		newScale = 0.85
		
	
	scale.x = newScale
	scale.y = newScale
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
