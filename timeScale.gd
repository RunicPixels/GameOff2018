extends Node

var timeScale = 1
var growth = 1
var freeze_frames = 1
var die = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	Engine.time_scale = timeScale
	if(not die):
		if(freeze_frames > 0):
			freeze_frames -= 1;
		elif(timeScale > 1): 
			timeScale -= 0.01 * growth
		elif(timeScale < 1):
			timeScale += 0.01 * growth
		
	else:
		if(freeze_frames > 0):
			get_tree().reload_current_scene()
			timeScale = 1;
			die = false;
		else:
			timeScale -= 0.01 * growth
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _set_time_scale(var scale, var growthScale, var freezeFrames = 0):
	timeScale = scale
	growth = growthScale
	freeze_frames = freezeFrames
	
func _die_time_scale(var scale, var growthScale, var freezeFrames = 0):
	_set_time_scale(scale,growthScale,freezeFrames)
	die = true;
	